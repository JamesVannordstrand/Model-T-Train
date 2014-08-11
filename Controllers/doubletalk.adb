--Locomotivation
--James Vannordstrand
with Bounded_Queue;
with Port_IO;
with Ada.Unchecked_Conversion;

package body DoubleTalk is

   package Phrase_Queue is new Bounded_Queue
     (Element_Type => Phrase_Strings.Bounded_String);

   BASE : constant Port_IO.Address_Range := 16#31F#;
   CONTROL : constant String := "01h";
   NULL_CHAR : constant String := "00h";

   type Voice_Array_Type is array (0 .. 7) of Voice_Range;
   Voices : Voice_Array_Type := (Paul, Vader, Bob, Pete,
                                 Randy, Biff, Skip, Robo);

   type TTSD_Rec is  -- Type for the TTD data register
      record
         Voice : Voice_Range;
         Char  : Character;
      end record;

   type TTSS_Array is array (0 .. 7) of Boolean;
   --Type for the TTD status register
   for TTSS_Array'Size use 8;
   for TTSS_Array'Component_Size use 1;

   function To_Byte is new Ada.Unchecked_Conversion
     (Source => String,
      Target => Port_IO.Byte);

   --------------------------------------------------
   protected type Bounded_Buffer is
      entry     Remove_Phrase (Phrase : out Phrase_Strings.Bounded_String);
      procedure Add_Phrase    (Phrase : in  Phrase_Strings.Bounded_String);
   private
      Buffer : Phrase_Queue.Queue_Type (Buffer_Size);
   end Bounded_Buffer;

   protected body Bounded_Buffer is

      entry Remove_Phrase (Phrase : out Phrase_Strings.Bounded_String)
        when not Phrase_Queue.Empty (Buffer) is
      begin
         Phrase_Queue.Dequeue (Queue => Buffer,
                               Item  => Phrase);
      end Remove_Phrase;

      procedure Add_Phrase (Phrase : in Phrase_Strings.Bounded_String) is
         garbage : Phrase_Strings.Bounded_String;
      begin
         if Phrase_Queue.Full (Buffer) then
            Phrase_Queue.Dequeue (Queue => Buffer,
                                  Item  => garbage);
         end if;
         Phrase_Queue.Enqueue (Queue => Buffer,
                               Item  => Phrase);
      end Add_Phrase;

   end Bounded_Buffer;

   The_Buffer : Bounded_Buffer;
   --------------------------------------------------
   task type Consumer;

   task body Consumer is
      Phrase : Phrase_Strings.Bounded_String;
   begin
      loop
         The_Buffer.Remove_Phrase (Phrase);

--         for Char_Index in Phrase_Strings.Length (Phrase) loop
--            ITTD.Char := Phrase_Strings.Element (Source => Phrase,
--                                                 Index  => Char_Index);
--         end loop;

      end loop;
   end Consumer;
   --------------------------------------------------

   procedure Speak (Phrase : in Phrase_Strings.Bounded_String;
                    Voice  : in Voice_Range) is

   begin
      The_Buffer.Add_Phrase (Phrase);

   end Speak;

end DoubleTalk;
