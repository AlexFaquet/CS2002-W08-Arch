#include <stdio.h>

#include "gcd.h"

void printDivisor(int a, int b) {
    printf("Greatest common divisor or %d and %d is %d.\n", a, b, gcd(a,b));
}

int main(void) {

    printDivisor(48, 128);
    printDivisor(18, 27);
    printDivisor(14, 0);
    printDivisor(-20,-16);
    printDivisor(-16,-20);
    printDivisor(0, 0);

    return 0;
} 
