/* #Некорректный синтаксис# */
int x == 5;

/* #Некорректная семантика — неизвестный тип переменной# */
MissingType y;

/* #Некорректная семантика — переменная не определена# */
z = 3;

/* #Некорректная семантика — переменная не инициализирована# */
String str;
while (str.length() < 20) str += " ";
