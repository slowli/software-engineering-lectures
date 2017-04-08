# $Создать посредник доступа к объектам.$
orb = CORBA.ORB_init([], CORBA.ORB_ID)
# $Получить стандартный сервис имен CORBA.$
name_service = orb.resolve_initial_references("NameService")
# $Привести полученный объект к правильному типу$
# $(в Python приведение предназначено для проверки типа объекта).$
name_service = name_service._narrow(CosNaming.NamingContextExt)

name = "test-service" # $имя зарегистрированного сервиса$
# $Найти сервис по имени.$
seq = name_service.resolve_str(name)
seq = seq._narrow(IntegerSequence)
# $Проверить, доступен ли сервис.$
if seq._non_existent(): raise Exception("Service unavailable")

# $При переходе от IDL к Python атрибуты преобразуются в функции$
# $\_get\_<имя атрибута> и \_set\_<имя атрибута>.$
print seq._get_name()
