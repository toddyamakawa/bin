//usr/bin/env go run "$0"; exit $?
// USAGE: go run types.go
// DESCRIPTION: Small example with basic types

package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func execute(cmd string, args ...string) {
	full_cmd := strings.Join(append([]string{"$", cmd}, args...), " ")
	fmt.Println(full_cmd)
	stdout, err := exec.Command(cmd, args...).Output()
	if err != nil {
		fmt.Printf("%s")
	}
	output := string(stdout[:])
	fmt.Printf(output)
}

func main() {
	execute("ls", "-l", "-h")
}

