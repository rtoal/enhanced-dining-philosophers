------------------------------------------------------------------------------
--  protected_counters.ads
--
--  This package defines protected type Counter. A counter is an integer with
--  an atomic decrement and test if zero operation.
--
--  Entries:
--
--    Decrement_And_Test_If_Zero (Is_Zero)  decrements the counter's value and
--                                          sets Is_Zero to whether the newly
--                                          updated value is 0.
------------------------------------------------------------------------------

package Protected_Counters is

   protected type Counter (Initial_Value : Positive) is
      procedure Decrement_And_Test_If_Zero (Is_Zero : out Boolean);
   private
      Value : Natural := Initial_Value;
   end Counter;

end Protected_Counters;
