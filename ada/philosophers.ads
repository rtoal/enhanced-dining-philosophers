------------------------------------------------------------------------------
-- philosophers.ads
--
-- This package supplies  a task  type for  the Philosophers  in the  Enhanced
-- Dining Philosophers simulation.  It also defines an array of philosophers.
--
-- Entries:
--
--   Here_Is_Your_Name (Name)   assigns the name Name to the philosopher.
--   Here_Is_Your_Food          gives the philosopher what she ordered.
--
-- Behavior:
--
--   First the philosopher waits for a name, then  enters a life cycle of com-
--   ing into the restaurant, thinking, ordering, then ((eating and paying) or
--   (getting a coupon) or (complaining)), then leaving.
--
-- Termination:
--
--   A philosopher "dies" be running out of money and just reaching the end of
--   its task body.
--
-- Note:
--
--   To keep the simulation from running too long, philosophers start with $30
--   and coupons are worth $5.
------------------------------------------------------------------------------

with Names, Orders;
use Names, Orders;

package Philosophers is

  task type Philosopher is
    entry Here_Is_Your_Name (Name: Philosopher_Name);
    entry Here_Is_Your_Food;
  end Philosopher;

  Philosopher_Array : array (Philosopher_Name) of Philosopher;

end Philosophers;
