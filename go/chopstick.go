package main

import "sync"

type Chopstick struct {
	mutex sync.Mutex
}

func (c *Chopstick) PickUp() {
	c.mutex.Lock()
}

func (c *Chopstick) PutDown() {
	c.mutex.Unlock()
}
