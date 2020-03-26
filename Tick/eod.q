dbdir:":/home/bjohnson/Data/db/"
tplogdir:`$":/home/bjohnson/Data/sym",string .z.D
\l ./sym.q
upd:insert
-11!tplogdir

tblsave:{
  .Q.en[`$dbdir;get x];
  (`$dbdir,"/",string[.z.D],"/",string[x],"/.d") set cols x;
  {[col;tbl]
    $[col in `sym`time;
      (`$dbdir,"/",string[.z.D],"/",string[tbl],"/",string[col]) set ?[tbl;();();col];
      (`$dbdir,"/",string[.z.D],"/",string[tbl],"/",string[col];17;1;0) set ?[tbl;();();col]
    ];
   }[;x] each cols x;
 }

tblsave each tables[] where 0<count each value each tables[]
