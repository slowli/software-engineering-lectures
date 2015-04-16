#!/usr/bin/python
# -*- coding: utf-8 -*-

def count(iterable):
	"""$Подсчитывает число вхождений в коллекцию каждого из элементов.$"""

	cnt = dict()
	for elem in iterable:
		cnt[elem] = (cnt[elem] + 1) if cnt.has_key(elem) else 1
	return cnt

# Возможные аргументы:
print count([1, 4, 5, 3, 2, 1, 1, 4]) # списки (list)
print count((0, 1, 0, 2, 1, 2)) # неизменяемые списки (tuple)
print count('foobarbazz') # строки (str)
print count({5, 4, 3, 2, 1}) # множества (set)
print count({'f': 'oo', 'b': 'ar'}) # ассоциативные массивы (dict)
