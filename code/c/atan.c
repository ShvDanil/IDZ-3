#include <stdio.h>
#include <math.h>

double calcAtan(double x, double accuracy) {
    double remember;
    double value = x;
    double iter = 2;
    do {
        remember = value;
        value += powl(-1, iter - 1) * powl(x, 2 * iter - 1) / (2 * iter - 1);
        ++iter;
    } while(fabs(remember - value) > accuracy);
    return value;
}

int main() {
    double x;
    scanf("%lf", &x);
    if (fabs(x) > 1) {
        printf("Incorrect input\n");
        return 0;
    }
    double accuracy = 0.0005;
    printf("%lf\n", calcAtan(x, accuracy));
    return 0;
}
