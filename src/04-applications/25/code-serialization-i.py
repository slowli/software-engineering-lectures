#!/usr/bin/python
# -*- coding: utf-8 -*-

import pickle

obj = SerializationTest('foo', '')
print obj # $\{'foo': 'foo', 'bar': ''\}$

# $Запись объекта в файл$
filename = 'dump'
with open(filename, 'wb') as fh:
    pickle.dump(obj, fh)

# $Чтение объекта из файла$
with open(filename, 'rb') as fh:
    other = pickle.load(fh)
    print type(other) # $<class '\_\_main\_\_.SerializationTest'>$
    print other # $\{'foo': 'foo', 'bar': 'bar'\}$
