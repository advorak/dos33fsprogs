   5  HOME
  10  PRINT "OOTW PROOF-OF-CONCEPT V1.7 BY DEATER"
  20  PRINT "                  DISK,LZ4 BY QKUMBA"
  25  PRINT "            ," 
  30  PRINT "ORIGINAL BY ERIC CHAHI"
  40  PRINT "INSPIRED BY PAUL NICHOLAS PICO-8 VERSION" 
  50  PRINT
  60  HTAB 9:PRINT "WASD OR ARROWS TO MOVE"
  70  HTAB 10:PRINT "SPACEBAR FOR ACTION"
  80  PRINT:PRINT
  85  HTAB 10:PRINT "  ______"
  90  HTAB 10:PRINT "A \/\/\/ PRODUCTION"
  92  PRINT
  95  HTAB 12:PRINT "APPLE ][ FOREVER"
 100  PRINT:PRINT "WHAT DO YOU WANT TO DO?"
 110  PRINT "1). START WITH INTRO MOVIE"
 120  PRINT "2). START AT CHECKPOINT 1 (IH8S)"
 130  PRINT "3). START AT CHECKPOINT 2 (RAGE)"
 140  INPUT A
 150  IF A < 1 OR A > 3 THEN 5
 160  POKE 5,(A-1)
 200  PRINT  CHR$ (4)"BRUN LOADER"
