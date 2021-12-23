
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
	//var a, b, c int = 1, 2, 3
	//d := 4
	fmt.Println("Hello " + world())
}

