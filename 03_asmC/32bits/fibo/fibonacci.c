int fibonacci(int n) {
// Definimos fibonacci con: f(0) = 0; f(1) = 1; f(2) = f(2 - 1) + f(2 - 2)
        if (n <= 0) {
                return 0;
        } else if (n <= 2) {
                return 1;
        }
        return fibonacci(n - 1) + fibonacci(n - 2);
}
