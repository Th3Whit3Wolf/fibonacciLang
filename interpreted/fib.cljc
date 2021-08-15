(defn fib [n]
  (if (<= n 2) 1
      (+ (fib (- n 1))
         (fib (- n 2)))))

(println (fib 40))