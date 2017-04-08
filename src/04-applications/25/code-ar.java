// $создание объекта$
Reader reader = new Reader();
reader.setFirstName("Alex");
reader.save(); // $сохранение в БД$
// $модификация объекта$
// $загрузка по первичному ключу$
Reader reader = Reader.getById(10); 
reader.setFirstName("Bob");
reader.update(); // $сохранение в БД$
// $удаление объекта$
Reader.deleteById(15);
