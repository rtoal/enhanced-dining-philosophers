------------------------------------------------------------------------------
--  cooks.adb
--
--  Implementation of the cooks.
------------------------------------------------------------------------------

with Ada.Strings.Unbounded, Randoms, Meals, Reporter;
use Ada.Strings.Unbounded, Randoms, Meals, Reporter;

package body Cooks is

   task body Cook is

      My_Name       : Unbounded_String;     -- Identification of the cook
      Current_Order : Order;                -- What she's currently preparing

      procedure Cook_The_Order is
      begin
         Report (My_Name & " is cooking " & Current_Order.Food);
         delay Duration (Random (3.0, 8.0));
         Report (My_Name & " puts " & Current_Order.Food & " under heat lamp");
         Heat_Lamp.Write (Current_Order);
      end Cook_The_Order;

      procedure Coffee_Break is
      begin
         Report (My_Name & " on coffee break");
         delay 10.0;
         Report (My_Name & " returns from coffee break");
      end Coffee_Break;

   begin
      accept Here_Is_Your_Name (Name : Cook_Name) do
         My_Name := To_Unbounded_String (Cook_Name'Image (Name));
      end Here_Is_Your_Name;
      Report (My_Name & " clocking in");

      Life_Cycle : loop
         for I in 1 .. 4 loop                 -- coffee break every fourth meal
            select
               accept Prepare (O : Order) do
                  Current_Order := O;       -- small critical section,
               end Prepare;                 -- ... don't hold waiter up!!
               Cook_The_Order;
            or
               accept Pink_Slip;            -- fired!
               exit Life_Cycle;
            end select;
         end loop;                          -- end of cooking four meals
         Coffee_Break;                      -- now take a break
      end loop Life_Cycle;                  -- end of 4-meal--break cycle

      Report (My_Name & " clocking out");
   exception
      when others => Report ("Error: Cook unexpectedly died");
   end Cook;

end Cooks;
