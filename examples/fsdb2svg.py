#!/usr/bin/env python3
# https://github.com/jacklee023/fsdb2svg/blob/main/fsdb2svg.py
#
# encoding: utf-8
################################################################################
# @Project Name : fsdb2svg
# @Author       : pyv
# @Create Time  : 2021-08-14 16:49:07
# @Modify Time  : 2021-08-14 22:49:12
# @File Name    : fsdb2svg.py
# @LICENSE      : MIT
# @History      : Initial version
# @Description  : wave(fsdb/vcd) -> wavedrom(json) -> svg
# @Usage        : python3 ./fsdb2svg.py -i demo.fsdb -r demo.rc
################################################################################

################################################################################
# import builtin package                                                       #
################################################################################
import os
import re
import sys
import math
import json
import demjson
import argparse
import subprocess
import configparser
import logging.config

################################################################################
# import third party package                                                   #
################################################################################
sys.path.append("./vcd2json")
sys.path.append("./wavedrompy/wavedrom")
from vcd2json import WaveExtractor
from wavedrom import WaveDrom

################################################################################
# import custom package                                                        #
################################################################################

################################################################################
# class declare                                                                #
################################################################################

class Wave2Img:
    def __init__(self, args, cfgs, log):
        self.args = args
        self.cfgs = cfgs
        self.log  = log
        self.fsdbfile = ""
        self.vcdfile  = ""
        self.jsonfile = ""
        self.svgfile  = ""

        self.wave_chunk = self.cfgs.getint('vcd2json', 'wave_chunk')
        self.start_time = self.cfgs.getint('vcd2json', 'start_time')
        self.end_time   = self.cfgs.getint('vcd2json', 'end_time')
        self.path_list  = self.cfgs.get('vcd2json', 'path_list').split('\n')[1:]
        self.handel_overlap = self.cfgs.get('wavedrom', 'handel_overlap')
        self.hscale_value   = self.cfgs.getint('wavedrom', 'hscale_value')

        self.read_rcfile()

        self.fsdb2vcd()
        self.vcd2json()
        self.json2svg()

    def fsdb2vcd(self):
        if self.args.input.endswith(".vcd"):
            self.vcdfile = self.args.input
        elif self.args.input.endswith(".fsdb"):
            self.fsdbfile = self.args.input
            self.vcdfile = re.sub(".fsdb$", ".vcd", self.fsdbfile)

            status, _ = subprocess.getstatusoutput('which fsdb2vcd')
            if status == 0:
                cmd = 'fsdb2vcd {} > {}'.format(self.fsdbfile, self.vcdfile)
                status, _ = subprocess.getstatusoutput(cmd)
                if status == 0:
                    self.log.info('fsdb2vcd done: {} -> {}'.format(self.fsdbfile, self.vcdfile))
                else:
                    self.log.fatal('fsdb2vcd failed')
                    sys.exit()
            else:
                self.log.fatal('command "fsdb2vcd" is not found')
                sys.exit()
        else:
            self.log.fatal('not support format')
            sys.exit()

    def vcd2json(self):
        self.jsonfile= re.sub(".vcd$", ".json", self.vcdfile)

        extractor = WaveExtractor(self.vcdfile, self.jsonfile, self.path_list)

        extractor.wave_chunk = self.wave_chunk
        extractor.start_time = self.start_time
        extractor.end_time   = self.end_time

        extractor.execute()
        self.log.info('vcd2json done: {} -> {}'.format(self.vcdfile, self.jsonfile))

        # format json
        with open(self.jsonfile, 'r') as fr:
            json_data = demjson.decode(fr.read())

        abbrev_flag = bool(self.handel_overlap == 'abbrev')
        hscale_flag = bool(self.handel_overlap == 'hscale')
        seg_max_len = 0
        chr_max_len = self.hscale_value * 4
        for i, elem in enumerate(json_data['signal']):
            for j, value in enumerate(elem):
                if not isinstance(value, dict):
                    continue
                if 'data' not in value:
                    continue

                if abbrev_flag:
                    data = []
                    for seg in value['data'].split(' '):
                        if len(seg) > chr_max_len:
                            seg = seg[:chr_max_len-2] + '--'
                        data.append(seg)
                    data = " ".join(data)

                    json_data['signal'][i][j]['data'] = data
                else:
                    for seg in value['data'].split(' '):
                        seg_max_len = max(seg_max_len, len(seg))

        if hscale_flag:
            json_data['config'] = {'hscale': math.ceil(seg_max_len / 4)}
        else:
            json_data['config'] = {'hscale': self.hscale_value}

        with open(self.jsonfile, 'w') as fw:
            json.dump(json_data, fw)

    def json2svg(self):
        self.svgfile = re.sub(".json$", ".svg", self.jsonfile)

        with open(self.jsonfile, 'r') as fr:
            json_data = json.load(fr)

        wavedrom = WaveDrom()

        output = wavedrom.renderWaveForm(0, json_data)

        output.saveas(self.svgfile)

        self.log.info('json2svg done: {} -> {}'.format(self.jsonfile, self.svgfile))

    def read_rcfile(self):
        if self.args.rcfile == '' or not os.path.exists(self.args.rcfile):
            return

        with open(self.args.rcfile, 'r') as fr:
            lines = fr.readlines()

        cursor_time = 0
        marker_time = 0
        signals = []
        prev_sig = None
        curr_sig = None
        hold_flag = False
        pat_signal = re.compile("(\[\d+:\d+\])$")
        pat_marker = re.compile("^marker\s+(\d+.\d+)")
        pat_cursor = re.compile("^cursor\s+(\d+.\d+)")

        for line in lines:
            line = line.strip()
            if 'cursor' in line:
                obj = pat_cursor.search(line)
                if obj is not None:
                    cursor_time = float(obj.group(1))
            elif 'marker' in line:
                obj = pat_marker.search(line)
                if obj is not None:
                    marker_time= float(obj.group(1))
            elif 'addSignal' in line:
                # rc file:
                # addSignal -h 15 /tb/dut/aclk
                # addSignal -h 15 -UNSIGNED -HEX -holdScope s_axis_data_tdata[15:0]
                st = line.split(' ')
                prev_sig = curr_sig
                # 含有 -holdScope 字样表示 hierarchy 与上一行信号一致
                if bool(st[-2] == '-holdScope'):
                    # 丢弃最后一个'/'后的内容, 再拼上当前信号名
                    curr_sig = '/'.join( prev_sig.split('/')[:-1] + [st[-1]] )
                else:
                    curr_sig = st[-1].strip('/')
                curr_sig = pat_signal.sub("", curr_sig)
                signals.append(curr_sig)

        self.path_list  = signals
        if cursor_time == 0 and marker_time == 0:
            return
        self.start_time = min(cursor_time, marker_time)
        self.end_time   = max(cursor_time, marker_time)


################################################################################
# funtion declare                                                              #
################################################################################

def get_args():
    parser = argparse.ArgumentParser()
    # st = "debug option"
    # parser.add_argument('-d',   '--debug', default = False, action='store_true', help=st)

    st = "rc file"
    parser.add_argument('-r',   '--rcfile', default = "", help=st)

    st = "config file"
    parser.add_argument('-c',   '--config', default = "config.ini", help=st)

    st = "input file(.fsdb/.vcd)"
    parser.add_argument('-i',   '--input', default = "", help=st)

    # st = "output file(.svg)"
    # parser.add_argument('-o',   '--output', default = "", help=st)

    return parser.parse_args()

def get_cfgs(cfgfile):
    configer = configparser.ConfigParser()
    configer.read(cfgfile, encoding='utf-8')
    return configer

def get_log(cfgfile = './logging.ini'):
    logging.config.fileConfig(cfgfile)
    logger = logging.getLogger(__name__)
    return logger

def main():
    args = get_args()
    cfgs = get_cfgs(args.config)
    log  = get_log(args.config)

    wave2img = Wave2Img(args, cfgs, log)

if __name__ == '__main__':
    main()

