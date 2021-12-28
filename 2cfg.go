//usr/bin/env go run "$0"; exit $?

// TODO: Implement this
// https://tutorialedge.net/golang/parsing-json-with-golang/

func main() {
	package main

import "fmt"

func do(i interface{}) {
	switch v := i.(type) {
	case int:
		fmt.Printf("%d\n", v)
	case string:
		fmt.Printf("\"%s\"\n", v, len(v))
	case array:
		fmt.Println("TODO")
	case hash:
		fmt.Println("TODO")
	default:
		fmt.Printf("UNKNOWN\n", v)
	}
}

func main() {
	fmt.Println("TODO")
}


