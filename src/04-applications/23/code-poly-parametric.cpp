template<typename T> string dump(const void* ptr, int size) {
	ostringstream oss;

	T* array = (T*) ptr;
	for (int i = 0; i < size / sizeof(T); i++) {
		oss << array[i];
		if (i < array_sz - 1) oss << " ";
	}
	return oss.str();
}

const string str("Datatype");
const void* ptr = (void*) str.c_str();
const int sz = str.size();

cout << dump<char>(ptr, sz) << endl; // D a t a t y p e
cout << dump<short>(ptr, sz) << endl; // 24900 24948 31092 25968
cout << dump<int>(ptr, sz) << endl; // 1635017028 1701869940
