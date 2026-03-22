#include "gcd.h"

static int gcd_recurse(int a, int b) {
    if (b == 0) {
		return a >= 0 ? a : -a;
	} else {
		return gcd_recurse(b, a % b);
	}
}

int gcd(int a, int b) {
    return gcd_recurse(a, b);
}

