------------------------------------------------------------------------------
--  meals.ads
--
--  A package containing the public data type Meal. A meal consists of an
--  entree, an optional soup, and an optional dessert. Three meal operations
--  are provided:
--
--    Random_Meal    A random meal.
--    Price (M)      The price of meal M.
--    S & M          appends unbounded string S and text of M.
------------------------------------------------------------------------------

with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package Meals is

   type Entree_Selection is (
      Paella,
      Wu_Hsiang_Chi,
      Bogracs_Gulyas,
      Spanokopita,
      Moui_Nagden,
      Sambal_Goreng_Udang
   );

   type Soup_Selection is (
      No_Soup,
      Albondigas
   );

   type Dessert_Selection is (
      No_Dessert,
      Berog
   );

   type Meal is record
      Entree  : Entree_Selection;
      Soup    : Soup_Selection;
      Dessert : Dessert_Selection;
   end record;

   function Random_Meal return Meal;
   function Price (M : Meal) return Float;
   function "&" (S : Unbounded_String; M : Meal) return Unbounded_String;

end Meals;
