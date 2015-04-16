String[] strings = new String[] { "foo", "bar" };
// работает, т.\,к. String[] — подтип Object[]
Arrays.sort(strings);
// Ковариантность делает опасной операции записи в массивы
Object[] objects = (Object[]) strings;
objects[0] = new Integer(5);
System.out.println(strings[0]); // исключение времени выполнения
