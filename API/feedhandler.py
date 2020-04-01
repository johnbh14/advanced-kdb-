import csv
import numpy
from qpython import qconnection
from qpython.qcollection import qlist
from qpython.qtype import QINT_LIST, QTIMESPAN_LIST, QSYMBOL_LIST, QFLOAT_LIST

q = qconnection.QConnection(host = 'localhost', port = 5001)
q.open()
print(q)
print('IPC version: %s. Is connected: %s' % (q.protocol_version, q.is_connected()))

f = open('trade.csv')
csv_f = csv.reader(f)

def str_to_ns(time_str):
     """
     input: time in a format `hh:mm:ss.up_to_9_digits`
     """
     h, m, s = time_str.split(":")
     int_s, ns = s.split(".")
     ns = map(lambda t, unit: numpy.timedelta64(t, unit),
              [h,m,int_s,ns.ljust(9, '0')],['h','m','s','ns'])
     return sum(ns)

for row in csv_f:
  q.sendSync(numpy.string_('.u.upd'), 
             numpy.string_('trade'), 
             [str_to_ns(row[0]), 
              numpy.string_(row[1]), 
              numpy.float64(row[2]), 
              numpy.int32(row[3])])
  
print('Done Publishing CSV')
