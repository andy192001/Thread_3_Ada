
with Ada.Text_IO, GNAT.Semaphores;
use Ada.Text_IO, GNAT.Semaphores;

with Ada.Containers.Indefinite_Doubly_Linked_Lists;
use Ada.Containers;

procedure Paral_3 is

   package String_Lists is new Indefinite_Doubly_Linked_Lists (String);
   use String_Lists;

   procedure Starter (Storage_Size : in Integer; GItem_Numbers : in Integer) is
      Storage : List;

      access_stor : Counting_Semaphore (1, Default_Ceiling);
      full_stor   : Counting_Semaphore (Storage_Size, Default_Ceiling);
      empty_stor  : Counting_Semaphore (0, Default_Ceiling);

      task type Producer(Item_Numbers : Integer);

      task type Consumer(Item_Numbers : Integer);

      task body Producer is
      begin

         for i in 1 .. Producer.Item_Numbers loop
            full_stor.Seize;
            access_stor.Seize;

            Storage.Append ("item " & i'Img);
            Put_Line ("Added item " & i'Img);

            access_stor.Release;
            empty_stor.Release;
            delay 0.1;
         end loop;

      end Producer;

      task body Consumer is
      begin

         for i in 1 .. Consumer.Item_Numbers loop
            empty_Stor.Seize;
            access_stor.Seize;

            declare
               item : String := First_Element (Storage);
            begin
               Put_Line ("Took " & item);
            end;

            Storage.Delete_First;

            access_stor.Release;
            full_Stor.Release;

            delay 0.2;
         end loop;

      end Consumer;

	t1: Consumer (GItem_Numbers);
	t2: Consumer (GItem_Numbers);
	t3: Consumer (GItem_Numbers);
	t4: Producer (GItem_Numbers);
	t5: Producer (GItem_Numbers);
	t6: Producer (GItem_Numbers);

   begin
      null;
   end Starter;

begin
   Starter (4, 20);
end Paral_3;
