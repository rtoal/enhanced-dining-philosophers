------------------------------------------------------------------------------
--  cooks.ads
--
--  This package supplies a task type for the Cooks in the Enhanced Dining
--  Philosophers simulation.  It also defines an array of cooks.
--
--  Entries:
--
--    Here_Is_Your_Name (Name)   assigns the name Name to the cook.
--    Prepare (O)                call this to tell the cook to prepare order O.
--                              The cook  simply takes the  order and lets the
--                              calling task  resume  immediately (the  caller
--                              does not have to wait while the cook cooks.
--    Pink_Slip                  "fires" the cook (terminating the task).
--
--  Behavior:
--
--    First the cook waits for a name, then reports to work.  After that, they
--    repeatedly: receives an order (from a waiter), cooks it, then puts it un-
--    der the heat lamp.  After every fourth meal, they go on a coffee break.
--    While waiting for an order from a waiter, they might get a pink slip.
--
--  Termination:
--
--    A cook is explicitly "fired" by the Host before the host dies.
------------------------------------------------------------------------------

with Names, Orders;
use Names, Orders;

package Cooks is

   task type Cook is
      entry Here_Is_Your_Name (Name : Cook_Name);
      entry Prepare (O : Order);
      entry Pink_Slip;
   end Cook;

   Cook_Array : array (Cook_Name) of Cook;

end Cooks;
