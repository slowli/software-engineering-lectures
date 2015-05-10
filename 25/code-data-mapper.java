Reader reader = new Reader();
reader.setFirstName("Alex");
entityManager.persist(reader);
// загрузка по первичному ключу заданной сущности
reader = entityManager.find("Reader", 10);
reader.setFirstName("Bob");
entityManager.persist(reader);
reader = entityManager.find("Reader", 15);
entityManager.delete(reader);
// сохраняет все изменения в БД
entityManager.flush(); 
