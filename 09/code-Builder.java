/* $Пример использования — Android API$ */
AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
builder.setMessage("Message")
	.setTitle("text")
	.setIcon(/* ... */)
	.setPositiveButton(/* ... */)
	.setNegativeButton(/* ... */);
AlertDialog dialog = builder.create();
