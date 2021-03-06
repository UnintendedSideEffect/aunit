------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                     A U N I T . A S S E R T I O N S                      --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--                                                                          --
--                       Copyright (C) 2000-2011, AdaCore                   --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT is maintained by AdaCore (http://www.adacore.com)                   --
--                                                                          --
------------------------------------------------------------------------------

--  Version for run-time libraries that support exception handling via
--  gcc builtin setjmp/longjmp

with AUnit.Last_Chance_Handler;

separate (AUnit.Assertions)
procedure Assert_Exception
  (Proc    : Throwing_Exception_Proc;
   Message : String;
   Source  : String := GNAT.Source_Info.File;
   Line    : Natural := GNAT.Source_Info.Line)
is
   procedure Exec;

   procedure Exec is
   begin
      Proc.all;
   end Exec;

   function My_Setjmp is new AUnit.Last_Chance_Handler.Gen_Setjmp (Exec);
begin
   if My_Setjmp = 0 then
      --  Result is 0 when no exception has been raised.
      Assert (False, Message, Source, Line);
   end if;
end Assert_Exception;
