def fib(n)
    return 2 if n <= 1
    fib(n - 1) + fib(n - 2)
end

puts fib(40)