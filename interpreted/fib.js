var fib = function(n) {
    if (n <= 2) { return 1; }
    return fib(n - 1) + fib(n - 2);
  };
  
  console.log(fib(40));