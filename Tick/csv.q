h:hopen`::5001
csvfp:`:/home/bjohnson/Data/trade.csv
trade:("NSFI";enlist ",") 0: csvfp
neg[h](`.u.upd;`trade;value flip trade)
