------------------------------------------------------------------------------
--  buffers.ads
--
--  A generic package for bounded, blocking FIFO queues (buffers). It exports
--  a proected type called 'Buffer'. Note that the maximum size of any buffer
--  of this type is taken from a single generic package parameter.
--
--  Generic Parameters:
--
--    Item        the desired type of the buffer elements.
--    Size        the maximum size of a buffer of type Buffer.
--
--  Entries:
--
--    Write (I)   write item I to the buffer.
--    Read (I)    read into item I from the buffer.
------------------------------------------------------------------------------

generic

   type Item is private;
   Size : Positive;

package Buffers is

   subtype Index is Integer range 0 .. Size - 1;
   type Item_Array is array (Index) of Item;

   protected type Buffer is
      entry Write (I : Item);
      entry Read (I : out Item);
   private
      Data  : Item_Array;
      Front : Index := 0;                   -- index of head (when not empty)
      Back  : Index := 0;                   -- index of next free slot
      Count : Integer range 0 .. Size := 0; -- number of items currently in
   end Buffer;

end Buffers;
