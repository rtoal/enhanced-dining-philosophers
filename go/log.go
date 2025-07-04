package main

import (
	"fmt"
	"math/rand"
	"time"
)

type Log struct {
	rng *rand.Rand
}

func NewLog() *Log {
	return &Log{
		rng: rand.New(rand.NewSource(time.Now().UnixNano())),
	}
}

func (log *Log) Say(msg string, args ...any) {
	fmt.Println(fmt.Sprintf(msg, args...))
}

func (log *Log) Do(maxSeconds int64, msg string, args ...any) {
	log.Say(msg, args...)
	half := maxSeconds / 2
	seconds := half + log.rng.Int63n(int64(half))
	time.Sleep(time.Duration(seconds) * time.Second)
}
