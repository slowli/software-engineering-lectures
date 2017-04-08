#!/usr/bin/python
# -*- coding: utf-8 -*-

# $именованная функция$
def square(x): return x*x
# $анонимная функция (лямбда-выражение)$
square = lambda x: x*x
print square(2) # 4
# $функция композиции (аргументы и результат — функции)$
compose = lambda fA, fB: lambda x: fB(fA(x))
# $возвести в квадрат, затем привести к текстовому виду$
f = compose(square, str)
numbers = [1, 2, 3]
# $map отображает каждый элемент коллекции с помощью заданной функции f$
print map(f, numbers) # ['1', '4', '9']
