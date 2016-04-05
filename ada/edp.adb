------------------------------------------------------------------------------
-- edp.adb
--
-- A compact Ada 95 simulation of the Enhanced Dining Philosophers Problem.
-- By "compact" it is meant that tasks representing simulation objects are
-- actually made visible to the simulation program as a whole rather than
-- being hidden in packages.
--
-- The objects in the simulation are:
--
--   5 philosophers;
--   5 chopsticks;
--   2 waiters;
--   3 cooks;
--   A host, who lets the philosophers into the restaurant and escorts them
--     out.
--   Meals, which are certain combinations of foods served by the restaurant;
--   Orders, which are of the form [philosopher, meal];
--   A heat lamp, under which cooks place the cooked orders and from which the
--     waiters pick them up (to bring them back to the philosophers);
--   A reporter, for logging events.
--
-- This is the main subprogram, EDP.  The entire program consists of twelve
-- packages and this subprogram.  Four packages are very general utilities;
-- the other eight are intrinsic to the simulation.  The packages are
--
--   Randoms                 a collection of operations producing randoms
--   Protected_Counters      exports a protected type Protected_Counter
--   Buffers                 generic package with bounded, blocking queue ADT
--   Reporter                unsophisticated package for serializing messages
--
--   Names                   names for the simulation objects
--   Meals                   Meal datatype and associated operations
--   Orders                  Order datatype, order-bin, and heat-lamp
--   Chopsticks              the chopsticks
--   Cooks                   the cooks
--   Host                    the host
--   Philosophers            the philosophers
--   Waiters                 the waiters
--
-- The main subprogram simply reports that the restaurant is open and then
-- initializes all library tasks.  The restaurant will be "closed" by the last
-- waiter to leave.
------------------------------------------------------------------------------

with Ada.Text_IO, Philosophers, Waiters, Cooks, Reporter;
use Ada.Text_IO, Philosophers, Waiters, Cooks, Reporter;

procedure EDP is
begin
  Report ("The restaurant is open for business");
  for C in Cook_Array'Range loop
    Cook_Array(C).Here_Is_Your_Name(C);
  end loop;
  for W in Waiter_Array'Range loop
    Waiter_Array(W).Here_Is_Your_Name(W);
  end loop;
  for P in Philosopher_Array'Range loop
    Philosopher_Array(P).Here_Is_Your_Name(P);
  end loop;
end EDP;
