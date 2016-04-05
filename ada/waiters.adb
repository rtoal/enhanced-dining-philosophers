------------------------------------------------------------------------------
-- waiters.adb
--
-- Implementation of the waiters.
------------------------------------------------------------------------------

with Philosophers, Cooks, Host, Meals, Orders, Reporter, Protected_Counters;
use Philosophers, Cooks, Host, Meals, Orders, Reporter, Protected_Counters;

with Ada.Exceptions, Ada.Strings.Unbounded, Ada.Text_IO;
use Ada.Exceptions, Ada.Strings.Unbounded;

package body Waiters is

  Waiters_Alive: Counter(Waiter_Array'Length);

  task body Waiter is

    My_Name: Unbounded_String;

    procedure Report_For_Work is
    begin
      Report (My_Name & " clocking in");
    end Report_For_Work;

    procedure Retrieve_Food_From_Kitchen_If_Possible is
      An_Order: Order;
    begin
      select
        Heat_Lamp.Read (An_Order);
        Report (My_Name & " gets " & An_Order.Food & " from heat lamp");
        Report (My_Name & " serves " & An_Order.Food);
        Philosopher_Array(An_Order.Diner).Here_Is_Your_Food;
      or
        delay 2.0;
        Report (My_Name & " found no food at heat lamp");
      end select;
    end Retrieve_Food_From_Kitchen_If_Possible;

    procedure Go_Home is
      Is_Zero: Boolean;
    begin
      Report (My_Name & " clocking out");
      Waiters_Alive.Decrement_And_Test_If_Zero (Is_Zero);
      if Is_Zero then
        Report ("The restaurant is closing down for the night");
      end if;
    end Go_Home;

  begin
    accept Here_Is_Your_Name (Name: Waiter_Name) do
      My_Name := To_Unbounded_String(Waiter_Name'Image(Name));
    end Here_Is_Your_Name;

    Report_For_Work;

    while not Norman_Bates'Terminated loop
      select
        accept Place_Order(An_Order: Order;
                           Customer: Philosopher_Name;
                           Cook_Immediately_Available: out boolean) do
          Cook_Immediately_Available := False;
          Report (My_Name & " takes an order from " & Philosopher_Name'Image(Customer));
          for C in Cook_Array'Range loop
            select
              Cook_Array(C).Prepare(An_Order);
              Cook_Immediately_Available := True;
              exit;
            else
              null;
            end select;
          end loop;
        end Place_Order;
      or
        delay 5.0;
      end select;
      Retrieve_Food_From_Kitchen_If_Possible;
    end loop;
    Go_Home;
  exception
    when E: others =>
      Report ("Error: " & My_Name & " unexpectedly dead from "
        & Exception_Information(E));
  end Waiter;

end Waiters;
