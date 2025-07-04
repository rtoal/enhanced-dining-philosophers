------------------------------------------------------------------------------
--  reporter.adb
--
--  Implementation of the Reporter package.
------------------------------------------------------------------------------

with Ada.Text_IO;
use Ada.Text_IO;

package body Reporter is

   protected Output is
      procedure Send (Message : String);
   end Output;

   protected body Output is
      procedure Send (Message : String) is
      begin
         Put_Line (Message);
      end Send;
   end Output;

   procedure Report (Message : String) is
   begin
      Output.Send (Message);
   end Report;

   procedure Report (Message : Unbounded_String) is
   begin
      Output.Send (To_String (Message));
   end Report;

end Reporter;
