// An order is placed by a philosopher and contains their name and the meal
// they want, together with the channel this reply needs to be sent back to
// after the order is fulfilled. When this happens, the cook that prepared the
// meal will put their name into the order.

package main

import (
	"fmt"
	"sync/atomic"
)

var nextInt atomic.Int64 = atomic.Int64{}

type Order struct {
	Id          int
	Meal        Meal
	Philosopher string
	Reply       chan *Order
	PreparedBy  string
	Cancelled   bool
}

func NewOrder(philosopher string, reply chan *Order) *Order {
	return &Order{
		Id:          int(nextInt.Add(1)),
		Meal:        RandomMeal(),
		Philosopher: philosopher,
		Reply:       reply,
	}
}

func (o *Order) MealString() string {
	var status string
	if o.Cancelled {
		status = "Cancelled "
	}
	return fmt.Sprintf("%sOrder #%d %s", status, o.Id, o.Meal)
}

func (o Order) ForString() string {
	return fmt.Sprintf("%s for %s", o.MealString(), o.Philosopher)
}

func (o *Order) ByString() string {
	return fmt.Sprintf("%s prepared by %s", o.MealString(), o.PreparedBy)
}

func (o *Order) ServesString() string {
	return fmt.Sprintf(
		"%s prepared by %s to %s",
		o.MealString(), o.PreparedBy, o.Philosopher)
}
