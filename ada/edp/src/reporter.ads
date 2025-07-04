------------------------------------------------------------------------------
--  reporter.ads
--
--  A plain package for serializing the output of messages to standard output.
------------------------------------------------------------------------------

with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package Reporter is

   procedure Report (Message : String);
   procedure Report (Message : Unbounded_String);

end Reporter;
