//usr/bin/env go run "$0"; exit $?
// USAGE: go run launch.go
// DESCRIPTION: Small example to launch shell command

package main

import (
	"bufio"
	"os/exec"
	"fmt"
	"os"
)

func main() {

	//filename := os.Args[1]
	file, err := os.Open("commands.txt")
	if err != nil {
		fmt.Println("Error opening file")
		return
	}
	defer file.Close()

	//pids = make([]int, 0)
	cmds := make([]exec.Cmd, 0)

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		fmt.Println(line)

		cmd := exec.Command("bash", "-c", line)
		if err := cmd.Start(); err != nil {
			fmt.Printf("Error starting command: %v\n", err)
			return
		}
		pid := cmd.Process.Pid
		println("PID: ", pid)
		//pids = append(pids, pid)
		cmds = append(cmds, *cmd)

	}

	// Wait for all commands to finish
	for _, cmd := range cmds {
		if err := cmd.Wait(); err != nil {
			fmt.Printf("Error waiting for command: %v\n", err)
			return
		}
	}

}

