# Лекции по программной инженерии

Набор презентаций для лекций по программной инженерии для студентов Физико-технического учебно-научного центра НАН Украины.
Сделаны с помощью (Xe)LaTeX и beamer.

(c) 2014, 2015, 2017, Алексей Островский

Текст лекций доступен под лицензией [CC BY-SA 4.0 International](LICENSE).
Выдержки кода и используемые программы доступны под лицензией [Apache 2.0](LICENSE-CODE).

## Содержимое репозитория

Репозиторий включает в себя следующие папки и файлы:
  * src/  
    Исходные TeX-файлы для презентаций лекций. Там же расположены краткие изложения
    лекций (файлы `README.md`).
  * common/  
    Общие для всех лекций исходные TeX-файлы.
  * gh-pages/  
    Файлы для построения [сайта GitHub Pages с лекциями](https://slowli.github.io/software-engineering-lectures).
  * out/  
    Папка для результатов компиляции, т.е. pdf-файлов лекций.
  * tmp/  
    Папка для промежуточных файлов. В частности, там хранятся логи компиляции.

## Построение

Построение осуществляется при помощи утилиты make. Необходим XeLaTeX
(работоспособность проверялась на TeXLive 2013).

### Команды построения презентаций

  * make *i*-a4, где *i*=01,02,03,...  
    Компилирует одну презентацию. В результате образуется файл out/*i*-*название лекции*.pdf -
    презентация на листе формата A4.
  * make *i*-beamer, где *i*=01,02,03,...  
    Компилирует одну презентацию. В результате образуется файл out/*i*-*название лекции*-beamer.pdf -
    презентация стандартного для проектора разрешения.
  * make *i*  
    Эквивалентно двум предыдущим командам.
  * make all-a4  
    Компилирует все презентации на листах A4.
  * make all-beamer  
    Компилирует все презентации для проектора.
  * make all, make install  
    make all-a4 + make all-beamer.
  * make clean  
    Удаляет промежуточные файлы компиляции.
  * make uninstall  
    Удаляет промежуточные файлы компиляции и pdf-файлы презентаций.

### Команды построения сайта GitHub Pages

Помимо предыдущих зависимостей, для локального тестирования сайта GitHub Pages
нужно установить генератор сайтов Jekyll. Руководство есть на сайте [Pages](https://pages.github.com/).

  * make gh-pages  
    Создает локальную версию веб-сайта.
  * make gh-serve
    Создает локальную версию веб-сайта и запускает демо веб-север, доступный
    по адресу http://localhost:4000/.
  * make gh-push-local  
    Пушит *исходные* материалы для построения веб-сайта в ветвь локального репозитория `gh-pages`;
    при этом используется опция `git push --force`, так что все предыдущие изменения
    в этой ветке стираются. Фактически, пушатся те данные, которые нужны для построения веб-сайта
    средствами GitHub Pages.
  * make clean-gh  
    Удаляет артефакты построения локального веб-сайта в папке **gh-pages**.

## Конфигурация

Основной параметр настройки — шрифты, используемые в презентациях. Файл, определяющий шрифты:
`common/fonts.def`.

Для GitHub Pages доступна опция `GH_PAGES_NOFILES`. Если эта переменная окружения
определена при вызове `make`, построение презентаций при генерации веб-сайта
пропускается. Полезно, например, для отладки дизайна.

Пример использования:
```sh
env GH_PAGES_NOFILES=1 make gh-serve
```
