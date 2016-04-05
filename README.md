# The Enhanced Dining Philosophers Problem

## You're Kidding?

No, not really. In case Dijkstra's original problem was too easy to code, or you'd like a larger multithreaded programming challenge, we offer a little extension. It's written to make use of all kinds of communication paradigms: asynchronous calls, blocking calls, balking calls, and calls with timeouts.

## Description

A restaurant has a dining room with a single round table with five seats and only one chopstick between each setting. The restaurant employs two waiters (TwiddleDee and TwiddleDum) and three chefs (Moe, Larry and Curly), and serves six different meals which are:

```
    Paella                $13.25
    Wu Hsiang Chi         $10.00
    Bogrács Gulyás        $11.25
    Spanokopita           $6.50
    Moui Nagden           $12.95
    Sambal Goreng Udang   $14.95
```

Each of the entrees comes with an optional soup (which is always Albóndigas, for $3.00) and an optional desert (Berog, for $3.50).

The restaurant's entire clientèle is made up of five philosophers who spend their lives coming in to the restaurant, thinking, eating, and then leaving. They insist on eating everything, even the Albóndigas soup, with two chopsticks, in the manner described by Dijkstra in the original Dining Philosophers Problem. Each philosopher begins life with a certain amount of money (perhaps $200) and dies when unable to afford another meal.

When a philosopher enters the dining room, she is seated at an available seat, thinks for a short amount of time, and places an order to an available waiter. The waiter takes the order to the kitchen and hand delivers it to a chef who will then prepare the meal (cooking takes a fair amount of time). When a chef finishes the meal he places it on the counter (this should be a FIFO queue, lest some orders rot) where a waiter will pick it up and deliver it to the philosopher who ordered it.

After eating (which takes some amount of time), the philosopher pays for her meal and leaves the restaurant. If she cannot afford the meal that she ordered, she dies; otherwise she will return at some later time. When all the philosophers have died, the restaurant closes down.

If a philosopher does not get her order placed within a certain amount of time she will just leave. If a waiter cannot immediately place an order with a chef (because all chefs are busy, say) he gives the philosopher a coupon good for $5.00 and she leaves the restaurant. Chefs take a hookah, er, a coffee break after every fourth meal they prepare.

The problem is then to ensure the proper functioning of the restaurant system. There must of course be absence of deadlock and starvation; furthermore, a waiter must not deliver an order to the wrong customer, etc. One solution makes the table a protected object which only allows four philosophers to be seated at any one time. Another alternative has one of the philosophers pick up chopsticks in the opposite order from the others.

Implementations can be animated with cool graphics, or employ a simple log. Examples of log messages (in English) are:

```
    The restaurant is now open for business.
    Philosopher Plato is being seated in chair 4.
    Philosopher Day has ordered Bogrács Gulyás from waiter TwiddleDum.
    Chef Moe is cooking the Spanokopita for Philosopher Russell.
    Philosopher Plato has paid $17.95 and left the restaurant.
    Waiter TwiddleDee is serving philosopher Descartes Paella and Berog.
    Philosopher Russell has left the restaurant without being served.
    Chef Curly has returned from a coffee break.
    The restaurant has closed down.
```
