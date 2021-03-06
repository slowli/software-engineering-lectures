# Управление изменениями и версиями ПО

Создание более-менее сложного программного обеспечения невозможно без управления
процессом разработки. Утилиты, использующиеся для автоматизации управления разработкой,
такие как системы управления версиями и средства автоматического построения,
вполне пригодны и для малых индивидуальных проектов. Эти инструменты помогают организовать
процесс создания ПО и, в некоторых случаях, заметно его ускорить.

Управление разработкой включаюет в себя четыре аспекта:

* **управление изменениями** — организация запросов на изменение, которые поступают
  от пользователей программной системы, заказчиков или разработчиков;
* **управление версиями** — хранение истории изменения документов, связанных
  с программным проектом (исходных файлов, документации и так далее);
* **построение системы** из исходных файлов;
* **управление выпусками** — подготовка компонентов системы для использования
  вне отдела разработки.

## Управление изменениями

Изменения — неотъемлемая часть эволюции программной системы. Изменения,
которые необходимо внести в ПО, оформляются в виде запросов (change request).
Запросы связаны с исправлением ошибок в системе, расширением ее функциональности
или адаптацией системы к новым условиям работы. Источником запроса могут быть
пользователи ПО, его заказчик или сами разработчики.

Перед тем, как запрос реализуется в виде изменений в файлах программного проекта,
он проходит несколько этапов:

* Запрос изучается на предмет адекватности и полноты. Во многих случаях поведение
  системы, воспринимаемое как ошибка, является нормальным; пользователь
  может запросить функциональность, которая уже присутствует в ПО, и так далее.
  Во многих случаях первоначальная формулировка запроса недостаточно полно
  описывает проблему или, наоборот, формулирует ее чересчур размыто.
* Для запроса оценивается приоритетность, круг пользователей, которые будут затронуты
  вносимыми изменениями, объем изменений и компоненты системы, которые необходимо
  модифицировать. Эти параметры позволяют понять, в каком порядке надо обрабатывать
  поступающие запросы на изменение.
* Создается план внесения изменений и тесты, позволяющие понять, что модификации
  произведены корректно. Если тесты проходятся удачно, запрос считается выполненным.

Для организации запросов на изменение существуют специализированные приложения,
например, [Bugzilla][bugzilla] (чаще всего такие программы построены по архитектуре
«клиент — сервер» с серверной частью, расположенной на отдельном компьютере
локальной сети). В других случаях обработка запросов входит в состав более общей
системы управления разработкой. Например, такой функционал присутствует на сайтах
хостинга программных проектов [GitHub][github] и [Google Code][gcode].

## Управление версиями

Системы управления версиями (СУВ) хранят всю историю продуктов разработки:
исходных файлов, документации, используемых библиотек и так далее. Главное назначение
СУВ — облегчение параллельной работы над приложением:

* Управление версиями позволяет автоматически разрешить конфликты, возникающие,
  когда одни и те же документы меняются несколькими разработчиками или во всяком
  случае облегчить нахождение компромисса.
* СУВ помогают вести разработку в нескольких направлениях за счет механизма
  ветвления / слияния (branch / merge). Например, при внедрении нового компонента
  в программную систему новый код выделяется в отдельную ветвь, а после проведения
  модульных и интеграционных тестов эта ветвь вливается в основную ветвь
  разработки (trunk).
* Использование СУВ значительно упрощает организацию выпусков программной системы:
  за счет использования меток (tag) понятно, какие версии компонентов ПО интегрируются
  друг с другом.

Выделяют два типа СУВ:

В **централизованных системах** информация о всех версиях компонентов хранится на
выделенном сервере в репозитории. Разработчики запрашивают данные из репозитория,
создавая рабочие копии (фактически, песочницы), в которых проводят изменения
и загружают файлы обратно на сервер.

В **распределенных системах** рабочие копии равнозначны и содержат всю историю правок,
информацию о ветвях и так далее. Обычно одна из рабочих копий находится на удаленном
хостинге (например, GitHub в случае СУВ Git), однако ее может и не существовать.
Есть мнение, что создание распределенных систем управления версиями в начале
XXI века сыграло важную роль в развитии программного обеспечения.

[bugzilla]: https://www.bugzilla.org/
[github]: https://github.com/
[gcode]: https://code.google.com/
