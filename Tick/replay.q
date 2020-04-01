\l ./sym.q
origLog:":/home/bjohnson/Data/sym",string .z.D
newLog:`$origLog,"tradeIBM.N"
newLog set ();
l:hopen newLog;
upd:{if[(x=`trade) & (`IBM.N in y[1;]);l enlist (`upd;x;enlist each y[;y[1;]?`IBM.N])]}

-11!`$origLog
