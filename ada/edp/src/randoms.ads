------------------------------------------------------------------------------
--  randoms.ads
--
--  A package for simple random number generation. Ada provides powerful and
--  sophisticated random number facilities which are a bit heavy handed for
--  simple applications. This package provides only the basics. Conceptually
--  it implements a single random number generator, from which you can obtain
--  random discrete values and floats. The operations are:
--
--    Reset             reset the generator to some unspecified state.
--    Reset (Seed)      reset the generator to the state specified by Seed.
--    Random (X, Y)     return a  random number in X..Y  inclusive. There are
--                      integer and floating point versions of this function.
--    Random_Discrete   a generic function to return a random value from a
--                      given discrete type.
------------------------------------------------------------------------------

package Randoms is

   procedure Reset;
   procedure Reset (Seed : Integer);
   function Random (X, Y : Integer) return Integer;
   function Random (X, Y : Float) return Float;
   generic type Element is (<>); function Random_Discrete return Element;

end Randoms;
