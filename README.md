software-egineering-lectures
============================

Лекции по программной инженерии

Набор презентаций для лекций по программной инженерии для студентов Физико-технического учебно-научного центра НАН Украины. 
Сделаны с помощью (Xe)LaTeX и beamer.

(c) 2014, Алексей Островский

Содержимое
============================

Репозиторий включает в себя следующие папки и файлы:
  01/,02/,...
    папки для исходных TeX-файлов соответствующей лекции
  common/
    общие для всех лекций исходные файлы
  out/
    папка для результатов компиляции, т.е. pdf-файлов лекций

Построение
============================

Построение осуществляется при помощи утилиты make. Необходим XeLaTeX (работоспособность проверялась на TeXLive 2013).
Команды построения:
  make <i>-a4, где <i>=01,02,03,...
    компилирует одну презентацию. В результате образуется файл out/<i>-<название лекции>.pdf - 
    презентация на листе формата A4.
  make <i>-beamer, где <i>=01,02,03,...
    компилирует одну презентацию. В результате образуется файл out/<i>-<название лекции>-beamer.pdf - 
    презентация стандартного для проектора разрешения.
  make <i>
    эквивалентно двум предыдущим командам.
  make all-a4
    компилирует все презентации на листах A4.
  make all-beamer
    компилирует все презентации для проектора
  make all
    make all-a4 + make all-beamer

Конфигурация
============================

Основной параметр настройки - шрифты, используемые в презентациях. Файл, определяющий шрифты:
  common/fonts.def

