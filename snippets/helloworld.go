
// USAGE: go run helloworld.go
// DESCRIPTION: Hello world

package main

import "fmt"

// Named return value
func world() (named string) {
	named = "World"
	// "Naked" return
	return
}

func main() {
	// Evaluate on return
	defer fmt.Println(world())
	fmt.Print("Hello ")
}

