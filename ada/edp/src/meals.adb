------------------------------------------------------------------------------
--  meals.adb
--
--  Implementation of the Meals package.
------------------------------------------------------------------------------

with Randoms;
use Randoms;

package body Meals is

   --  Store the prices of each individual meal component in tables for
   --  efficient lookup.

   E_Price : constant array (Entree_Selection) of Float := (
      13.25, 10.00, 11.25, 6.50, 12.95, 14.95
   );
   S_Price : constant array (Soup_Selection) of Float := (0.00, 3.00);
   D_Price : constant array (Dessert_Selection) of Float := (0.00, 3.50);

   --  The price of a meal is found simply by looking up the prices of each of
   --  the three components of the meal in the price tables and adding them up.

   function Price (M : Meal) return Float is
   begin
      return E_Price (M.Entree) + S_Price (M.Soup) + D_Price (M.Dessert);
   end Price;

   --  To compute a random meal we pick a random entree selection, a random
   --  soup selection, and a random dessert selection.   Generators for
   --  random selections are constructed by instantiating the generic
   --  function Random_Discrete.

   function Random_Entree is new Random_Discrete (Entree_Selection);
   function Random_Soup is new Random_Discrete (Soup_Selection);
   function Random_Dessert is new Random_Discrete (Dessert_Selection);

   function Random_Meal return Meal is
   begin
      return (Random_Entree, Random_Soup, Random_Dessert);
   end Random_Meal;

   --  This is the function which gives the text describing a meal. The
   --  string takes one of four forms, depending on the presence or absence
   --  of soup and dessert:
   --
   --    1. <entree>
   --    2. <entree> with <soup>
   --    3. <entree> with <dessert>
   --    4. <entree> with <soup> and <dessert>

   function "&" (S : Unbounded_String; M : Meal) return Unbounded_String is
      Result : Unbounded_String := S;
   begin
      Append (Result, Entree_Selection'Image (M.Entree));
      if M.Soup /= No_Soup or else M.Dessert /= No_Dessert then
         Append (Result, " WITH ");
         if M.Soup /= No_Soup then
            Append (Result, Soup_Selection'Image (M.Soup));
            if M.Dessert /= No_Dessert then
               Append (Result, " AND ");
            end if;
         end if;
         if M.Dessert /= No_Dessert then
            Append (Result, Dessert_Selection'Image (M.Dessert));
         end if;
      end if;
      return Result;
   end "&";

end Meals;
