
// USAGE: go run types.go
// DESCRIPTION: Small example with basic types

package main

import "fmt"

func main() {
	b1, b2 := true, false
	fmt.Printf("- %v (%T), %v (%T)\n" , b1, b1, b2, b2)

	s := "string"
	fmt.Printf("- %q (%T)\n", s, s)

	var u uint = 1 << 64 - 1
	i := int(u)
	fmt.Printf("- %v (%T), %v (%T)\n", i, i, u, u)
	fmt.Println("- int  int8  int16  int32  int64")
	fmt.Println("- uint uint8 uint16 uint32 uint64 uintptr")
	fmt.Println("- byte // (uint8)")

	fmt.Println("- float32 float64")
	fmt.Println("- complex64 complex128")
}

