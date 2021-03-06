# Документирование ПО

Один из важных этапов разработки программного обеспечения — создание документации.
Документирование ПО (системная документация) помогает разработчикам и отделу сопровождения
понять структуру системы и назначение ее элементов. Кроме того, часть документации
(пользовательская документация) предназначена для конечных пользователей
и администраторов — она позволяет понять, как нужно устанавливать и разворачивать
систему, какие функции она предоставляет и каким образом можно бороться
с ошибками, возникающими при ее работе.

Существует и другая классификация документов на программную систему:

* Некоторые документы (например, документ спецификации требований и планы проектирования
  / конструирования компонентов системы) описывают процессы разработки.
  Эти документы — часть системной документации.
* Остальные документы описывают продукты процессов разработки. Эти документы
  могут быть как системными (например, UML-схемы модулей системы), так и пользовательскими
  (например, руководства по использованию).

Согласно гибкой методологии разработки, объем документации на систему,
в особенности описывающей процессы, должен быть сведен к минимуму. На составление
исчерпывающей документации уходит много времени и средств; из-за высокой скорости
эволюции структура программной системы меняется настолько быстро, что документация
устаревает практически сразу после выхода. Разумеется, полностью отказаться
от документации нельзя: в любом случае сохраняется потребность в пользовательской
документации, такой как руководства.

Документация к современным системам доступна в нескольких форматах:

Наиболее старый способ документирования — **печатные документы** (например, книги,
посвященные определенному программному комплексу). Преимущество печатной документации
— в легкости восприятия и (при адекватной организации) в упрощении поиска по неформальным
запросам (когда известно, что ищется, но сложно сформулировать конкретные
ключевые слова).

Электронная документация, которая может быть локальной (например, Readme-файлы)
или встраиваться в глобальную систему документации (man, help и так далее).
По сравнению с печатной документацией, электронные документы могут быть более детальными;
в них легче проводить поиск по ключевым словам.

Документация, размещенная в Интернете. К этому виду документации относятся не только
составленные разработчиками и размещенные на сайте продукта материалы (Getting started,
справочные руководства и тому подобное), но и документы, генерируемые пользователями
системы. К такой Web 2.0-документации относятся wiki по программным продуктам,
записи в блогах, ответы на сайтах вроде stackoverflow и так далее.

Документацию можно писать вручную с использованием систем редактирования и верстки
(например, Microsoft Word или LaTeX). Более продуктивный способ — использование
генераторов вроде [Javadoc][javadoc] и [Doxygen][doxy]. В этом случае документирование
осуществляется в исходных файлах программной системы, чаще всего в виде
специальных комментариев (хотя возможны другие варианты, например, строки документации
в Python). Такую документацию можно читать при просмотре исходного кода программы;
она же используется для контекстной помощи в средах разработки. Наконец, при помощи
генератора документацию можно выделить в отдельные документы (например, HTML
или страницы man).

Развитие идеи комментирования исходного кода программы — грамотное программирование
([literate programming][literate]), придуманное Дональдом Кнутом для системы TeX.
В этом подходе роли комментариев и кода меняются: текст программы представляет собой
эссе на естественном языке с отдельными фрагментами кода. С помощью специальных
инструментов код выделяется из эссе и формирует исходный код на определенном
языке программирования; после этого можно проводить компиляцию и т.д.
Грамотное программирование позволяет проследить ход мысли разработчика программы,
лучше понять ее структуру и решения, принятые при разработке. При всех своих преимуществах,
грамотное программирование применяется редко — не все программисты любят
писать эссе.

[javadoc]: http://www.oracle.com/technetwork/java/javase/documentation/index-jsp-135444.html
[doxy]: http://www.stack.nl/~dimitri/doxygen/
[literate]: https://en.wikipedia.org/wiki/Literate_programming
