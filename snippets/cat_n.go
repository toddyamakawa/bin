//usr/bin/env go run "$0"; exit $?
// USAGE: go run cat_n.go
// DESCRIPTION: Small example that is the equivalent of `cat -n`

package main

import (
    "bufio"
    "fmt"
    "os"
)

func main() {
    lines := make(chan string)

    go func() {
        scanner := bufio.NewScanner(os.Stdin)
        for scanner.Scan() {
            lines <- scanner.Text()
        }
        close(lines)
    }()

    lineNumber := 1
    for line := range lines {
        fmt.Printf("%d: %s\n", lineNumber, line)
        lineNumber++
    }
}

