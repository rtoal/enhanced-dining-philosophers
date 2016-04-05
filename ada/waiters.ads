------------------------------------------------------------------------------
-- waiters.ads
--
-- This package supplies a task type for the Waiters in the Enhanced Dining
-- Philosophers simulation, and an array of waiters.
--
-- Entries:
--
--   Here_Is_Your_Name (Name)      assigns the name Name to the waiter.
--   Place_Order(O, P, Available)  gets order O from Philosopher P and
--                                 returns whether a cook is immediately
--                                 available to cook it.
--
-- Behavior:
--
--   A waiter does nothing until assigned a name; then he reports in.  At work
--   a waiter runs back and forth between the table and the kitchen.  At the
--   table he tries to pick up an order from a customer, but he only waits
--   five seconds for one.  If he picks one up he takes it to the kitchen and
--   tries to get a chef to cook it. If none of the cooks are immediately
--   available the waiter gives a coupon to the philosopher that placed the
--   order.  At the kitchen the waiter waits up to two seconds to pick up an
--   order from the heat lamp, and then delivers it to the philosopher that
--   ordered it.
--
-- Termination:
--
--   A waiter dies naturally (by completing its task body) whenever he notes
--   that the host has died.  Before dying, he checks to see if he is the last
--   waiter to leave (by decrementing and testing a protected counter) and if
--   so, he "locks up" the restaurant (reports that it is closing).
------------------------------------------------------------------------------

with Names, Orders;
use Names, Orders;

package Waiters is

  task type Waiter is
    entry Here_Is_Your_Name (Name: Waiter_Name);
    entry Place_Order(An_Order: Order;
                      Customer: Philosopher_Name;
                      Cook_Immediately_Available: out boolean);
  end Waiter;

  Waiter_Array: array (Waiter_Name) of Waiter;

end Waiters;
