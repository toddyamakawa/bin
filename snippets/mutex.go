//usr/bin/env go run "$0"; exit $?
// USAGE: mutex.go
// DESCRIPTION: Small mutex example

// https://go.dev/tour/concurrency/9

package main

import (
	"fmt"
	"sync"
)

func UnsafeIncrement(counter *int, mutex *sync.Mutex, waitgroup *sync.WaitGroup) {
	defer waitgroup.Done()
	*counter++
}

func SafeIncrement(counter *int, mutex *sync.Mutex, waitgroup *sync.WaitGroup) {
	defer waitgroup.Done()
	mutex.Lock()
	defer mutex.Unlock()
	*counter++
}

func Value(counter *int, mutex *sync.Mutex) int {
	mutex.Lock()
	defer mutex.Unlock()
	return *counter
}

func main() {
	var mutex sync.Mutex
	var waitgroup sync.WaitGroup
	counter := 0

	for i := 0; i < 3000; i++ {
		waitgroup.Add(1)
		go SafeIncrement(&counter, &mutex, &waitgroup)
	}
	fmt.Println(Value(&counter, &mutex))

	waitgroup.Wait()
	fmt.Println(Value(&counter, &mutex))

	for i := 0; i < 3000; i++ {
		waitgroup.Add(1)
		go UnsafeIncrement(&counter, &mutex, &waitgroup)
	}
	waitgroup.Wait()
	fmt.Println(Value(&counter, &mutex))
}

