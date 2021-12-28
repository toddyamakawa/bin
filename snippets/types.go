//usr/bin/env go run "$0"; exit $?
// USAGE: go run types.go
// DESCRIPTION: Small example with basic types

package main

import "fmt"

type Point struct {
	X, Y int
}

func main() {
	b1, b2 := true, false
	fmt.Printf("- %v (%T), %v (%T)\n", b1, b1, b2, b2)

	s := "string"
	fmt.Printf("- %q (%T)\n", s, s)

	var u uint = 1<<64 - 1
	i := int(u)
	fmt.Printf("- %v (%T), %v (%T)\n", i, i, u, u)
	fmt.Println("- int  int8  int16  int32  int64")
	fmt.Println("- uint uint8 uint16 uint32 uint64 uintptr")
	fmt.Println("- byte // (uint8)")

	fmt.Println("- float32 float64")
	fmt.Println("- complex64 complex128")

	p1 := Point{1, 2}
	pp1 := &p1
	p2 := Point{}
	fmt.Println("- struct:", p1, pp1, pp1.X, pp1.Y, p2)

	//a := make([]int, 0, 5) // len(a)=0, cap(a)=5
	a := []string{"Hello", "World"}
	fmt.Println("- array:", a)
	fmt.Println("  - cap() =", cap(a))
	fmt.Println("  - len() =", len(a))

	var m = map[string]string{
		"key": "value",
	}
	fmt.Println("- map:", m)
}
