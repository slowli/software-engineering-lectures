class SomeClass { /* ... */ }
class Subclass : SomeClass { /* ... */ }

SomeClass obj = // ...;

// $Приведение типа с проверкой;$
// $если obj — не экземпляр Subclass, возбуждается исключение.$
try {
	Subclass checkedSub = (Subclass) obj;
} catch (InvalidCastException e) {
	/* ... */
}

// $Безусловное приведение;$
// $если obj — не экземпляр Subclass, uncheckedSub == null.$
Subclass uncheckedSub = obj as Subclass;
