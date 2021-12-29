//usr/bin/env go run "$0"; exit $?
// USAGE: reader.go
// DESCRIPTION: Small Reader example

// https://go.dev/tour/methods/21
// https://go.dev/tour/methods/23

package main

import (
	"fmt"
	"io"
	"strings"
)

type rot13Reader struct {
	r io.Reader
}

func (r rot13Reader) Read(p []byte) (n int, err error) {
	n, err = r.r.Read(p)
	for i := 0; i < n; i++ {
		b := p[i]
		if b >= 'a' && b <= 'z' {
			b = ((b - 'a' + 13) % 26) + 'a'
		} else if b >= 'A' && b <= 'Z' {
			b = ((b - 'A' + 13) % 26) + 'A'
		}
		p[i] = b
	}
	return
}

func main() {

	s := strings.NewReader("Lbh penpxrq gur pbqr!")
	r := rot13Reader{s}
	// Print directly to stdout
	//io.Copy(os.Stdout, &r)

	b := make([]byte, 8)
	for {
		n, err := r.Read(b)
		fmt.Printf("n = %v err = %v b = %v\n", n, err, b)
		fmt.Printf("b[:n] = %q\n", b[:n])
		if err == io.EOF {
			break
		}
	}
}

