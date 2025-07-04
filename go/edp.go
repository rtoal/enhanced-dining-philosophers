// An implementation of the rather bizarre "Enhanced Dining Philosophers"
// simulation, defined at https://cs.lmu.edu/~ray/notes/edp/.

package main

import (
	"sync"
	"time"
)

var philosophers = []string{"Kaṇāda", "Zhaozhou", "Hume", "Haack", "Khayyám"}
var waiters = []string{"Miria", "Isaac"}
var cooks = []string{"Eren", "Mikasa", "Armin"}
var table = NewTable(len(philosophers))

var log = NewLog()

// Philosphers place orders into the tableOrders channel. Waiters take orders
// from the tableOrders channel and place them into the kitchenOrders channel.
// Because the scenario is that a cook must be available immediately, we
// need a way to determine that all cooks are busy. A buffered channel whose
// capacity is the number of cooks will do the trick. If there is space in the
// channel, that means a cook will be able to pick it up. If a waiter tries to
// submit an order to the kitchen and the channel is full, it means that all
// cooks are busy. A cook takes orders from the kitchenOrders channel and
// prepares the meals. The prepared meals are placed into the heatLamp channel.

var tableOrders = make(chan *Order, len(philosophers))
var kitchenOrders = make(chan *Order, len(cooks))
var heatLamp = make(chan *Order, len(philosophers))

// Cooks repeatedly read orders from the kitchen order queue (the channel
// kitchenOrders), prepare a meal, and place the finished meal under the heat
// lamp (channel heatLamp). They take a break after every fourth meal they
// prepare. They will stop when the kitchenOrders channel is closed.

func Cook(name string, wg *sync.WaitGroup) {
	defer wg.Done()
	mealsPrepared := 0
	for order := range kitchenOrders {
		if order.Cancelled {
			log.Say("%s rejecting cancelled order #%d", name, order.Id)
			continue
		}
		log.Do(10, "%s is preparing %s", name, order.ForString())
		order.PreparedBy = name
		heatLamp <- order
		if mealsPrepared++; mealsPrepared%4 == 0 {
			log.Do(5, "%s is taking a coffee break", name)
		}
	}
	log.Say("%s is done cooking for the day", name)
}

// Waiters take orders from philosophers at the tableOrders channel, then take
// them to the cooks via the kitchenOrders channel. Because waiters both read
// and write, they have to be told when their shift is over. The main goroutine
// will write to this channel when it is time to send the waiters home.

var ShiftOver = make(chan struct{})

func Waiter(name string, wg *sync.WaitGroup) {
	defer wg.Done()
	for {
		select {
		case order := <-tableOrders:
			// Pick up order from table, forward to kitchen or give coupon
			log.Say("%s received %s", name, order.ForString())
			select {
			case kitchenOrders <- order:
				log.Say("%s placed %s with kitchen", name, order.ForString())
			default:
				// Coupons are given if all cooks are cooking
				log.Say(
					"%s could not place %s with kitchen, giving coupon",
					name, order.ForString())
			}
		case preparedOrder := <-heatLamp:
			if preparedOrder.Cancelled {
				log.Say("%s rejecting cancelled order #%d", name, preparedOrder.Id)
				continue
			}
			log.Say("%s takes %s from heat lamp", name, preparedOrder.ByString())
			log.Do(2, "%s serves %s", name, preparedOrder.ByString())
			preparedOrder.Reply <- preparedOrder
		case <-ShiftOver:
			log.Do(2, "%s is done waiting for the day", name)
			return
		}
	}
}

// Philosophers live until they run out of money. The always get up after
// eating, to let other philosophers sit down.

func Philosopher(name string, left *Chopstick, right *Chopstick, wg *sync.WaitGroup) {
	defer wg.Done()
	replyChannel := make(chan *Order, 1)
	for wealth := 25.0; wealth > 0.0; {
		table.SitDown()
		log.Do(8, "%s has sat down and is now thinking", name)
		order := NewOrder(name, replyChannel)
		log.Say("%s requests %s", name, order.MealString())
		tableOrders <- order
		select {
		case receivedOrder := <-replyChannel:
			log.Say("%s received %s", name, receivedOrder.ByString())
			for receivedOrder != order {
				log.Say("%s received wrong order, waiting for right one", name)
				receivedOrder = <-replyChannel
				log.Say("%s received %s", name, receivedOrder.ByString())
			}
			left.PickUp()
			log.Say("%s picked up left chopstick", name)
			right.PickUp()
			log.Say("%s picked up right chopstick", name)
			log.Do(5, "%s is eating %s", name, receivedOrder.ByString())
			right.PutDown()
			log.Say("%s put down right chopstick", name)
			left.PutDown()
			log.Say("%s put down left chopstick", name)
			wealth -= order.Meal.Price()
			log.Say("%s paid and now has $%.2f left", name, wealth)
		case <-time.After(8 * time.Second):
			order.Cancelled = true
			log.Say("%s did not get prompt service, cancels order #%d", name, order.Id)
		}
		table.Leave()
		log.Do(2, "%s has left the table", name)
	}
	log.Do(2, "%s has gone home", name)
}

// The main function of the simulation creates all the objects, starts the
// goroutines, and manages an orderly shutdown.

func main() {
	log.Say("The restaurant is open")

	chopsticks := make([]*Chopstick, len(philosophers))
	for i := range chopsticks {
		chopsticks[i] = &Chopstick{}
	}

	// Philosophers will do their own thing
	var philosopherGroup sync.WaitGroup
	for i, name := range philosophers {
		philosopherGroup.Add(1)
		go Philosopher(
			name,
			chopsticks[i],
			chopsticks[(i+1)%len(chopsticks)],
			&philosopherGroup)
	}

	// Start up the employees: cooks and waiters
	var employeeGroup sync.WaitGroup
	for _, name := range cooks {
		employeeGroup.Add(1)
		go Cook(name, &employeeGroup)
	}
	for _, name := range waiters {
		employeeGroup.Add(1)
		go Waiter(name, &employeeGroup)
	}

	// The philosophers finish on their own so we wait for them first. After
	// they finish, tell each waiter their shift is over. Next, close the
	// channel that the cooks read from so they can finish. Because it still
	// takes time for the employees to actually finish, we have a final wait
	// on the employeeGroup.
	philosopherGroup.Wait()
	for range waiters {
		ShiftOver <- struct{}{}
	}
	close(kitchenOrders)
	employeeGroup.Wait()

	// Clean up nicely by closing the last remaining buffered channel.
	close(heatLamp)

	log.Say("The restaurant is closed")
}
