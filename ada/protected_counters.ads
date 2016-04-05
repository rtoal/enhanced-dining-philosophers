------------------------------------------------------------------------------
-- protected_counters.ads
--
-- This package defines protected type Counter.  A counter is basically an in-
-- teger which starts  with some initial positive value and is decremented (by
-- 1) by calling  tasks.  When a task  decrements  the counter it  is informed
-- whether or  not it made  the counter  go  to zero.  The  decrement and test
-- are bound together in a critical  section because without this  protection, 
-- the zero might be missed or discovered by two different tasks!
--
-- Entries:
--
--   Decrement_And_Test_If_Zero (Is_Zero)   decrements the counter's value and
--                                          sets Is_Zero to  whether the newly
--                                          updated value is 0.
------------------------------------------------------------------------------

package Protected_Counters is

  protected type Counter (Initial_Value: Positive) is
    procedure Decrement_And_Test_If_Zero (Is_Zero: out Boolean);
  private
    Value: Natural := Initial_Value;
  end Counter;

end Protected_Counters;
