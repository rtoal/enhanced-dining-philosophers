------------------------------------------------------------------------------
-- randoms.adb
--
-- Body for the  simple random number  generation package.  The implementation
-- uses a single private random number generator for floats; this generator is
-- called to obtain both integers and floats by using appropriate scaling.
------------------------------------------------------------------------------

with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random;

package body Randoms is

  G: Generator;

  procedure Reset is
  begin
    Reset (G);
  end Reset;

  procedure Reset (Seed: Integer) is
  begin
    Reset (G, Seed);
  end Reset;

  -- To generate a random float in X .. Y inclusive we first use the built-in
  -- generator to get a value R in 0.0 .. 1.0.  Mapping R into the range
  -- X .. Y is done essentially by computing X+R*(Y-X), however the compu-
  -- tation Y-X may overflow for very large Y and very small X.  So we
  -- distribute the multiplication, and order terms in such a way as to
  -- avoid overflow.
  
  function Random (X, Y: Float) return Float is
    R: Float := Random(G);
  begin
    return X - X*R + Y*R;
  end Random;

  -- Obtaining a random integer in a given range is a little tricky.  We
  -- start by obtaining a random float R such that 0.0 <= R < 1.0.
  -- We essentially partition the range [0.0, 1.0> into Y-X+1 equal
  -- subranges so that each subrange corresponds to an integer in X..Y
  -- inclusive.  To map the random float into the right integer we compute
  -- Floor(X+R*(Y-X+1)). Note the importance of the open upper bound!
  -- Of course we have to guard against overflow and maximize precision
  -- of the floating point computations by ordering the terms in a nice
  -- manner.

  function Random (X, Y: Integer) return Integer is
    R: Float := Random(G);
  begin
    while R = 1.0 loop
      R := Random(G);
    end loop;
    return Integer(Float'Floor(Float(X) - Float(X)*R + Float(Y)*R + R));
  end Random;

  -- Random values in a discrete range are easy to generate; we just get a
  -- random integer and convert the type.

  function Random_Discrete return Element is
    Min: Integer := Element'Pos(Element'First);
    Max: Integer := Element'Pos(Element'Last);
  begin
    return Element'Val(Random(Min, Max));
  end Random_Discrete;

begin
  Reset (G);
end Randoms;
