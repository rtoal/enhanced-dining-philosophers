------------------------------------------------------------------------------
--  protected_counters.adb
--
--  Implementation of the protected counter.
------------------------------------------------------------------------------

package body Protected_Counters is

   protected body Counter is

      procedure Decrement_And_Test_If_Zero (Is_Zero : out Boolean) is
      begin
         Value := Value - 1;
         Is_Zero := Value = 0;
      end Decrement_And_Test_If_Zero;

   end Counter;

end Protected_Counters;
