proc fib(n: uint64): uint64 =
    if n <= 1: return 2
    return fib(n - 1) + fib(n - 2)

echo fib(40)