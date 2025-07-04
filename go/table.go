// One of the classic solutions to the dining philosophers problem is to use a
// semaphore to limit the number of philosophers that can sit at the table to
// the number of seats minus one.

package main

type Table struct {
	semaphore chan struct{}
}

func NewTable(seats int) *Table {
	return &Table{semaphore: make(chan struct{}, seats-1)}
}

func (t *Table) SitDown() {
	t.semaphore <- struct{}{}
}

func (t *Table) Leave() {
	<-t.semaphore
}
