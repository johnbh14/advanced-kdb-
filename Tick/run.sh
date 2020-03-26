#!/bin/bash

#CONFIG

FP="/home/bjohnson/Repositories/advanced-kdb-/Tick/"
TP=5001
RDB1=5002
RDB2=5003
FH=5004
CEP=5005

tp() { echo "Starting Tickerplant" ; nohup ~/q/l32/q $FP"tp.q" $FP"sym" ~/Data -p $TP & }
rdb1() { echo "Starting Real-Time Database 1" ; nohup ~/q/l32/q $FP"rdb1.q" localhost:5001 localhost:5006 -p $RDB1 & }
rdb2() { echo "Starting Real-Time Database 2" ; nohup ~/q/l32/q $FP"rdb2.q" localhost:5001 localhost:5006 -p $RDB2 & }
fh() { echo "Starting Feedhandler" ; nohup ~/q/l32/q $FP"fh.q" -p $FH & }
cep() { echo "Starting Complex Event Processor" ; nohup ~/q/l32/q $FP"cep.q" -p $CEP & }

if [ $# -lt 1 ] ; then
	echo "Not enough command line parameters"
	exit 1
fi

if [ "$1" == "START" ] ; then

	if [ "$2" == "ALL" ] ; then
		tp ; rdb1 ; rdb2 ; fh ; cep
	fi

	if [ "$2" == "TP" ] ; then
		tp
	fi

	if [ "$2" == "RDB1" ] ; then
		rdb1
	fi

	if [ "$2" == "RDB2" ] ; then
		rdb2
	fi

	if [ "$2" == "FH" ] ; then
		fh
	fi

	if [ "$2" == "CEP" ] ; then
		cep
	fi
fi

if [ "$1" == "STOP" ] ; then

	if [ "$2" == "ALL" ] ; then
		kill $(ps aux | grep '[t]p.q' | awk '{print $2}')
		kill $(ps aux | grep '[r]db1.q' | awk '{print $2}')
		kill $(ps aux | grep '[r]db2.q' | awk '{print $2}')
		kill $(ps aux | grep '[f]h.q' | awk '{print $2}')
		kill $(ps aux | grep '[c]ep.q' | awk '{print $2}')
	fi

	if [ "$2" == "TP" ] ; then
		kill $(ps aux | grep '[t]p.q' | awk '{print $2}')
	fi

	if [ "$2" == "RDB1" ] ; then
		kill $(ps aux | grep '[r]db1.q' | awk '{print $2}')
	fi

	if [ "$2" == "RDB2" ] ; then
		kill $(ps aux | grep '[r]db2.q' | awk '{print $2}')
	fi

	if [ "$2" == "FH" ] ; then
		kill $(ps aux | grep '[f]h.q' | awk '{print $2}')
	fi

	if [ "$2" == "CEP" ] ; then
		kill $(ps aux | grep '[c]ep.q' | awk '{print $2}')
	fi
fi

if [ "$1" == "TEST" ] ; then
	echo "Tickerplant Process PID"
	pgrep -f tp.q
	echo "Real-Time Database 1 Process PID"
	pgrep -f rdb1.q
	echo "Real-Time Database 2 Process PID"
	pgrep -f rdb2.q
	echo "Feedhandler Process PID"
	pgrep -f fh.q
	echo "Complex Event Processor"
	pgrep -f cep.q	
fi

echo "FINISHED"
