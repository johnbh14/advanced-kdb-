/In order to locate the errors, I just attempted running upd in error-trapping mode for each line of the tplog. 
/I was able to see the type errors this way, and I could see the flattened entry beginning at index 6 by doing a simple get on the tplog. 
/Below is the code to fix the errors and replay the new log.

/load schema
trade:([]sym:`symbol$();price:`float$();size:`long$())

/load in original tplog
origTpLog:get `:tplog;

/cast the sym column in the third entry from char to symbol
origTpLog[2;2]:update `$'sym from origTpLog[2;2];

/cast the size column in the fifth entry from float to long
origTpLog[4;2]:update floor size from origTpLog[4;2];

/the seventh entry should be the seventh,eighth, and ninth entries combined
origTpLog[6]:(origTpLog[6;0];origTpLog[7;0];origTpLog[8;0]);
origTpLog:(origTpLog til 7),enlist (origTpLog 9);

/cast the sym column in the tenth entry from char to symbol
origTpLog[7;2]:update `$'sym from origTpLog[7;2];

/save new tplog
`:newTpLog set ();
h:hopen`:newTpLog;
h each enlist each origTpLog;
hclose h;

/replay the new tplog to ensure it now works
upd:{x insert y};
-11!`:newTpLog;
