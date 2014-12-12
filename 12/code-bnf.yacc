expression ::= element | list
element    ::= number | variable
number     ::= [+-]?['0'-'9']+
variable   ::= ['A'-'Z''a'-z']'\w'*
list       ::= '[' (expression',')*expression ']' | '[]'
