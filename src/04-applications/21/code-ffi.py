import ctypes

# $Загрузка базовой библиотеки C$
libc = ctypes.CDLL('libc.so.6')
# $Вызов функции C \code{time}$
# $Эквивалентный вызов в C: t = time(NULL);$
t = libc.time(None)
print t
