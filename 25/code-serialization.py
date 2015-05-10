#!/usr/bin/python
# -*- coding: utf-8 -*-

class SerializationTest(object):
    def __init__(self, foo, bar):
        self.foo = foo
        self.bar = bar

    def __getstate__(self):
        odict = self.__dict__.copy() # клонировать словарь объекта
        del odict['bar'] # не сериализовать поле bar объекта
        return odict

    def __setstate__(self, state):
        self.__dict__.update(state) # скопировать все сохраненные поля
        self.bar = 'bar'

    def __str__(self): return str(self.__dict__)
