# Шаблоны проектирования

Вслед за созданием общей архитектуры системы, которая соответствует
нефункциональным требованиям к программной системе, нужно спроектировать отдельные
элементы программы (они отвечают функциональным требованиям). В лекции идет речь
об одном из основных подходов к проектированию компонентов программной системы —
объектно-ориентированному проектированию. В рамках этого подхода система разбивается
на объекты (данные и функции по их обработке), которые взаимодействуют между собой.

Компоненты обычно не создают с нуля, а используют готовые наработки — шаблоны проектирования.
Обычно выделяют три основных группы шаблонов:

* порождающие (creational patterns) — шаблоны, которые помогают создавать
  новые объекты;
* структурные (structural patterns) — шаблоны, отвечающие за взаимодействие
  между объектами;
* поведенческие (behavioral patterns) — шаблоны, которые реализуют передачу информации
  между несколькими объектами.

Иногда к этим группам добавляют четвертую — шаблоны параллельного исполнения
(concurrency patterns).

Шаблоны проектирования полезны не только при разработке, они также демонстрируют
основные особенности объектно-ориентированного проектирования — наследование,
полиморфизм, инкапсуляцию, а также разделение интерфейсов и реализации.
