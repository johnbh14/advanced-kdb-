\p 5006
trade:flip `time`sym`price`size!("NSFI";",") 0: `:trade.csv
.z.ws:{neg[.z.w].j.j select from trade where sym=`$x}
