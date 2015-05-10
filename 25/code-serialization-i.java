final String filename = "dump";
final SerializationTest testObj = // …

// Запись в поток; основой для потока служит файл
FileOutputStream fos = new FileOutputStream(filename);
ObjectOutputStream oos = new ObjectOutputStream(fos);
oos.writeObject(testObj);
oos.close();

// Чтение из потока
FileInputStream fis = new FileInputStream(filename);
ObjectInputStream ois = new ObjectInputStream(ins);
final SerializationTest otherObj = (SerializationTest) ois.readObject();
ois.close();

// При правильной имплементации метода SerializationTest.equals() 
// исходный и восстановленный объект должны совпадать
assertEquals(testObj, otherObj);
