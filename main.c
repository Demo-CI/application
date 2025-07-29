// application/main.c
#include <stdio.h>
#include "libstatic.h"
#include "libshared.h"

int main(void) {
    int sum     = add(3, 4);
    int product = multiply(3, 4);

    printf("Sum: %d\n", sum);
    printf("Product: %d\n", product);

    return 0;
}
