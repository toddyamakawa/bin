//usr/bin/env go run "$0"; exit $?
// USAGE: go run timeout.go
// DESCRIPTION: Small example with basic types

package main

import (
	"fmt"
	"math/rand"
	"time"
)

func main() {
	done := make(chan int, 10)    // Buffer to ensure all goroutines can signal without blocking
	timeout := make(chan struct{}) // Channel to signal timeout

	rand.Seed(time.Now().UnixNano()) // Seed the random number generator

	// Start 10 goroutines
	for i := 1; i <= 10; i++ {
		go func(id int) {
			sleepTime := rand.Intn(10) + 1 // Random sleep time between 1 and 10 seconds
			fmt.Printf("Goroutine %d sleeping for %d seconds...\n", id, sleepTime)
			time.Sleep(time.Duration(sleepTime) * time.Second)
			done <- id // Signal that this goroutine is done
		}(i)
	}

	// Start a goroutine to signal timeout after 5 seconds
	go func() {
		time.Sleep(5 * time.Second)
		timeout <- struct{}{}
	}()

	// Listen for goroutine completions or timeout
	for i := 0; i < 10; i++ {
		select {
		case id := <-done:
			fmt.Printf("Goroutine %d done.\n", id)
		case <-timeout:
			fmt.Println("Timeout reached. Exiting...")
			return
		}
	}

	// If we get here, it means all goroutines completed before the timeout
	fmt.Println("All goroutines completed successfully.")
}

