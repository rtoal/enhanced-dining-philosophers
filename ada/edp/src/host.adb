------------------------------------------------------------------------------
--  host.adb
--
--  Implementation of the host.
------------------------------------------------------------------------------

with Chopsticks, Cooks, Reporter;
use Chopsticks, Cooks, Reporter;

package body Host is

   task body Ryuk is

      --  Keep track of the number of empty seats.
      --  Initially all seats are empty, so the number of empty seats is
      --  the actual number of seats we have, which is equal to the number
      --  of chopsticks, i.e. the number of elements in Chopstick_Array.

      Number_Of_Empty_Seats : Natural := Chopstick_Array'Length;

      --  Keep track of the number of living philosophers.
      --  Initially all philosophers are alive, so the number of living
      --  philosophers is equal to the number of total philosophers, which
      --  is the same as the number of initially empty seats.

      Number_Of_Living_Philosophers : Natural := Number_Of_Empty_Seats;

   begin
      Report ("The host is coming to life");

      --  Loop around, doing host things:

      loop
         select
            accept Leave do
               Number_Of_Empty_Seats := Number_Of_Empty_Seats + 1;
            end Leave;
         or
            when (Number_Of_Empty_Seats >= 2) =>
            accept Enter do
               Number_Of_Empty_Seats := Number_Of_Empty_Seats - 1;
            end Enter;
         or
            accept Death_Announcement;
            Number_Of_Living_Philosophers := Number_Of_Living_Philosophers - 1;
            exit when Number_Of_Living_Philosophers = 0;
         end select;
      end loop;

      --  Fire all the cooks:

      for I in Cook_Array'Range loop
         Cook_Array (I).Pink_Slip;
      end loop;

   end Ryuk;

end Host;
