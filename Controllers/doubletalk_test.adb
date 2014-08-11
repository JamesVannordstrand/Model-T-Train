-- Locomotivation
-- Mike Miller

with DoubleTalk;
use DoubleTalk;


procedure Doubletalk_Test is
begin
   Speak (Phrase => Phrase_Strings.To_Bounded_String ("This is Robo"),
                                Voice  => Robo);
   Speak (Phrase => Phrase_Strings.To_Bounded_String ("This is Skip"),
                                Voice  => Skip);
   Speak (Phrase => Phrase_Strings.To_Bounded_String ("This is Biff"),
                                Voice  => Biff);
   Speak (Phrase => Phrase_Strings.To_Bounded_String ("This is Randy"),
                                Voice  => Randy);
   Speak (Phrase => Phrase_Strings.To_Bounded_String ("This is Pete"),
                                Voice  => Pete);
   Speak (Phrase => Phrase_Strings.To_Bounded_String ("This is Bob"),
                                Voice  => Bob);
   Speak (Phrase => Phrase_Strings.To_Bounded_String ("This is Vader"),
                                Voice  => Vader);
   Speak (Phrase => Phrase_Strings.To_Bounded_String ("this is Paul"),
                                Voice  => Paul);
end Doubletalk_Test;
