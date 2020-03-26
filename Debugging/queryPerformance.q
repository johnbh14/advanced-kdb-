StringtoDate:{[x]{$[10h~abs type x;x:"D"$x;-14h~ type x;x:x;`date$x]}'[x]}
input:raze 500000#enlist("2010.01.01";2010.01.02)

myFunc:{
  @[x; where 10=type each x; {"D"$x}]
 }

\ts StringtoDate input
\ts myFunc input
