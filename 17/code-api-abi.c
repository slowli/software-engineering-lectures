#include<stdio.h>

/* $Определение функции printf в stdio.h — часть API$ */
/* $и одинаково для всех режимов компиляции.$ */
/* $\textbf{int} printf(\textbf{const} \textbf{char}* format, ...);$ */

/* $Определение размеров типов данных — часть ABI.$ */

int main() {
    printf("sizeof(int) == %zd\n", sizeof(int));
    printf("sizeof(long) == %zd\n", sizeof(long));
    printf("sizeof(long double) == %zd\n", sizeof(long double));
    printf("sizeof(void*) == %zd\n", sizeof(void*));
    return 0;
}
