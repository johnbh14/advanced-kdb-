\l ./sym.q
h:hopen`::5001
h(`.u.sub;`trade;`)
h(`.u.sub;`quote;`)
s:cols agg
agg:`sym xkey agg
upd:{[tabname;tabdata]
  agg::update vol:"i"$0^vol from agg;
  if[tabname=`trade;
    agg::agg pj select vol:sum size by sym from tabdata;
/    {agg::update pmax:pmax | x`price from agg where sym=x`sym;
/     agg::update pmin:?[null pmin;x`price;pmin & x`price] from agg where sym=x`sym
/     } each tabdata
    {agg[x`sym;`pmax]:agg[x`sym;`pmax]|x[`price];
     agg[x`sym;`pmin]:$[null agg[x`sym;`pmin];x[`price];agg[x`sym;`pmin]&x[`price]];
     } each tabdata
  ];
  if[tabname=`quote;
    `agg upsert select last time, last bid, last ask by sym from tabdata
  ];
 };

.z.ts:{
  0N!string .z.T;
  if[string[.z.T] like "??:??:00.???";
    0N! agg;
    0N!"Sending agg records";
    neg[h](`.u.upd;`agg;value flip s xcols 0!agg)
  ];
 };

\t 1000
