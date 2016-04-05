------------------------------------------------------------------------------
-- chopsticks.adb
--
-- Implementation of the Chopsticks package.
------------------------------------------------------------------------------

package body Chopsticks is

  protected body Chopstick is

    entry Pick_Up when not Up is
    begin
      Up := True;
    end Pick_Up;

    entry Put_Down when Up is
    begin
      Up := False;
    end Put_Down;

  end Chopstick;

end Chopsticks;
