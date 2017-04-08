#!/usr/bin/python
# -*- coding: utf-8 -*-

import math
class Foo(object): pass

# $В Python все переменные — потомки object:$
if (isinstance(5, object) # $целые числа$
    and isinstance(2.71828, object) # $вещественные числа$
    and isinstance(True, object) # $булевы переменные$
    and isinstance(None, object) # $нулевой указатель$
    and isinstance('str', object) # $строки$
    and isinstance([2, '3'], object) # $последовательности$
    and isinstance({'foo':'bar'}, object) # $ассоциативные таблицы$
    and isinstance(map, object) # $функции$
    and isinstance(Foo(), object) # $объекты$
    and isinstance(Foo, object) # $классы$
    and isinstance(math, object) # $модули$
):
    print 'OK' # OK
