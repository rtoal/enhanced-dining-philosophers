------------------------------------------------------------------------------
-- buffers.adb
--
-- Implementation of the Buffers package.
------------------------------------------------------------------------------

package body Buffers is

  protected body Buffer is

    entry Read (I: out Item) when Count > 0 is
    begin
      I := Data(Front);                     -- copy the element out
      Front := (Front + 1) mod Size;        -- position Front to new front
      Count := Count - 1;                   -- note that now one less item
    end Read;

    entry Write (I: Item) when Count < Size is
    begin
      Data(Back) := I;                      -- insert into buffer storage
      Back := (Back + 1) mod Size;          -- next item will go here
      Count := Count + 1;                   -- note that now one more item
    end Write;

  end Buffer;

end Buffers;
