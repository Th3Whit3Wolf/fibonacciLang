fn fib(n int) int {
    if n <= 2 { return 1 }
    return fib(n - 1) + fib(n - 2)
}

fn main() {
    println(fib(40))
}