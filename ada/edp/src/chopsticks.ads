------------------------------------------------------------------------------
--  chopsticks.ads
--
--  This package supplies a task type for the Chopsticks in the Enhanced Dining
--  Philosophers simulation and also an array of Chopsticks.
--
--  Entries:
--
--    Pick_Up     call this to pick the chopstick up.
--    Put_Down    call this to put the chopstick down.
--
--  Behavior:
--
--    A chopstick is first picked up, then put down, then picked up, then put
--    down, and so on.
------------------------------------------------------------------------------

with Names;
use Names;

package Chopsticks is

   protected type Chopstick is
      entry Pick_Up;
      entry Put_Down;
   private
      Up : Boolean := False;
   end Chopstick;

   Chopstick_Array : array (Chopstick_Name) of Chopstick;

end Chopsticks;
