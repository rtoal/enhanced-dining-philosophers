------------------------------------------------------------------------------
--  philosophers.adb
--
--  Implementation of the philosophers.
------------------------------------------------------------------------------

with Randoms, Meals, Chopsticks, Host, Orders, Reporter, Waiters;
use Randoms, Meals, Chopsticks, Host, Orders, Reporter, Waiters;

with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package body Philosophers is

   task body Philosopher is
      My_Index : Philosopher_Name;
      My_Name  : Unbounded_String;
      Wealth   : Float := 30.00;
      Left     : Chopstick_Name;
      Right    : Chopstick_Name;
      My_Order : Order;
      Cooking  : Boolean;
   begin
      accept Here_Is_Your_Name (Name : Philosopher_Name) do
         My_Index := Name;
         My_Name := To_Unbounded_String (Philosopher_Name'Image (Name));
      end Here_Is_Your_Name;
      Left := Chopstick_Name (Philosopher_Name'Pos (My_Index));
      Right := (Chopstick_Name'Pos (Left) + 1) mod (Chopstick_Name'Last + 1);

      while Wealth > 0.0 loop
         Norman_Bates.Enter;
         Report (My_Name & " enters the cafe");
         Report (My_Name & " is thinking");
         delay Duration (Random (1, 3));
         My_Order := (My_Index, Random_Meal);
         Report (My_Name & " has decided to order " & My_Order.Food);

         select
            Waiter_Tasks (Waiter_Name'Val (Random (0, 1))).Place_Order (
               My_Order, My_Index, Cooking);
         or
            delay 35.0;
            Report (My_Name & " cancels order and complains of lousy service");
         end select;

         if Cooking then
            accept Here_Is_Your_Food;
            Chopstick_Array (Right).Pick_Up;
            Chopstick_Array (Left).Pick_Up;
            Report (My_Name & " is eating " & My_Order.Food);
            delay (12.0);
            Chopstick_Array (Right).Put_Down;
            Chopstick_Array (Left).Put_Down;
            Report (My_Name & " pays for the " & My_Order.Food);
            Wealth := Wealth - Price (My_Order.Food);
         else
            Report (My_Name & " receives a coupon");
            Wealth := Wealth + 5.00;
         end if;

         Report (My_Name & " leaves the restaurant");
         Norman_Bates.Leave;
      end loop;
      Report (My_Name & " died a normal death from overeating");
      Norman_Bates.Death_Announcement;
   exception
      when others => Report ("Error: " & My_Name & " dead unexpectedly");
   end Philosopher;

begin
   for I in Philosopher_Tasks'Range loop
      Philosopher_Tasks (I) := new Philosopher;
   end loop;
end Philosophers;
