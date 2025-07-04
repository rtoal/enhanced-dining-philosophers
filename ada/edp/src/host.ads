------------------------------------------------------------------------------
--  host.ads
--
--  This package defines the task for the host. The host allows the philoso-
--  phers to enter and leave the restaurant. It also keeps track of how many
--  philosophers have died. The host is called Ryuk.
--
--  Entries:
--
--    Enter               Allows you to enter the restaurant provided there are
--                        at least two empty seats.
--    Leave               Allows you to leave the restaurant.
--    Death_Announcement  Records the fact that a philosopher has died.
--
--  Behavior:
--
--    The host just sits around waiting for someone to ask him to escort her
--    in to or out of the restaurant, or to inform him of a (philosopher's)
--    death. He will take requests to be seated only if there are at least two
--    free seats at the table. He will take requests to leave at any time.
--    After all the philosophers have informed him of their deaths, he will
--    fire all the cooks.
--
--  Termination:
--
--    The host keeps track of how many philosophers are alive. When this count
--    reaches zero, he will fire all the cooks and then subsequently terminate
--    himself.
--
--  Note:
--
--   The use of a host in the Dining Philosophers Problem is controversial be-
--   cause the system  relies on the "ethics" of our  philosophers. The phil-
--   osophers must be honest and always use the host to enter and leave, and
--   always inform the host that they are dead (or terminally ill and unable
--   to eat again!) One advantage, though, of having the philosophers inform-
--   ing the host of their death is that the host does not need to poll to see
--   how many philosophers are alive.
------------------------------------------------------------------------------

package Host is

   task Ryuk is
      entry Enter;
      entry Leave;
      entry Death_Announcement;
   end Ryuk;

end Host;
