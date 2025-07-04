------------------------------------------------------------------------------
--  orders.ads
--
--  This package contains the public data type Order and a heat lamp to store
--  finished orders under.
--
--  Types:
--
--    Order      An order is simply a pair consisting of a meal and the
--               philosopher who ordered it.
--
--  Objects:
--
--    Heat_Lamp  When cooks are finished preparing an order they place it
--               under this heat lamp. A waiter should come by and pick it up
--               and take it to the table. This object is represented as a
--               bounded blocking queue with a capacity of five orders.
------------------------------------------------------------------------------

with Names, Meals, Buffers;
use Names, Meals;

package Orders is

   type Order is record
      Diner : Philosopher_Name;               -- Who ordered it
      Food  : Meal;                           -- What they ordered
   end record;

   --  The order bin and the heat lamp are simply queues of orders, so first
   --  instantiate the generic package for blocking queues:

   package Order_Buffers is new Buffers (Order, 5);
   use Order_Buffers;

   --  Now declare the buffer objects:

   Heat_Lamp : Buffer;

end Orders;
