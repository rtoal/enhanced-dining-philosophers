------------------------------------------------------------------------------
-- names.ads
--
-- This package defines a collection of enumerated types that name some of the
-- objects in the  simulation: namely the  philosophers,  chopsticks, waiters, 
-- and cooks.
--
-- Note that we  enforce the  rule that  there have  to be the  same number of
-- chopsticks as philosophers.
--
-- Note also  that names are not  given to the host, order bin,  heat lamp, or
-- reporter since these are essentially unique objects.
------------------------------------------------------------------------------

package Names is

  type Philosopher_Name is (Russell, Church, Empedocles, Rand, Kant);
  type Chopstick_Name is range 0..Philosopher_Name'Pos(Philosopher_Name'Last);
  type Waiter_Name is (Tweedledee, Tweedledum);
  type Cook_Name is (Moe, Larry, Curly);

end Names;
