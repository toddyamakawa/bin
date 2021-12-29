//usr/bin/env go run "$0"; exit $?
// USAGE: mutex.go
// DESCRIPTION: Small mutex example

// https://go.dev/tour/concurrency/9

package main

import (
	"fmt"
	"sync"
	"time"
)

func Increment(counter *int, mutex *sync.Mutex) {
	mutex.Lock()
	*counter++
	mutex.Unlock()
}

func Value(counter *int, mutex *sync.Mutex) int {
	mutex.Lock()
	defer mutex.Unlock()
	return *counter
}

func main() {
	var mutex sync.Mutex
	counter := 0
	for i := 0; i < 3000; i++ {
		go Increment(&counter, &mutex)
	}
	go fmt.Println(Value(&counter, &mutex))
	time.Sleep(time.Second)
	fmt.Println(Value(&counter, &mutex))
}

