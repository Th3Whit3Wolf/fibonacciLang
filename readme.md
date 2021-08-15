 # Language Benchmark
The code performs a recursive fibonacci to the 40th position with the result of 102,334,155.
This is the correct version where the sequence starts at 0.

All tests are run on:
- OS: Nixos

### How to run them
- Install nix
    - The quickest way to install Nix is to open a terminal and run the following command (as a user other than root with sudo permission):
        - curl -L https://nixos.org/nix/install | sh
- nix-shell or nix develop
- b

b is an alias for the benchmark script that will update the readme.

The benchmark uses hyperfine to run two warmup and ten real runs

Last benchmark was ran on 0


## Natively Compiled

| Language |   Mean [s]    | Min [s] | Max [s] |    Relative |
| :------- | :-----------: | ------: | ------: | ----------: | 
| `C`      | 0.863 ± 0.011 |   0.851 |   0.889 | 3.01 ± 0.05 |
| `C++`    | 0.861 ± 0.011 |   0.852 |   0.891 | 3.01 ± 0.05 |
| `D`      | 0.858 ± 0.009 |   0.849 |   0.880 | 2.99 ± 0.05 |
| `Go`     | 0.865 ± 0.032 |   0.847 |   0.954 | 3.02 ± 0.12 |
| `Lisp`   | 0.810 ± 0.163 |   0.348 |   0.881 | 2.83 ± 0.57 |
| `Nim`    | 0.287 ± 0.003 |   0.284 |   0.295 | 1.00 ± 0.02 |
| `Rust`   | 0.287 ± 0.004 |   0.282 |   0.293 | 1.00 ± 0.02 |
| `V`      | 0.287 ± 0.006 |   0.281 |   0.301 | 1.00 ± 0.02 |
| `Zig`    | 0.287 ± 0.003 |   0.283 |   0.294 |        1.00 |

## Interpreted

| Language            |    Mean [s]    | Min [s] | Max [s] |         Relative |
| :------------------ | :------------: | ------: | ------: | ---------------: | 
| `Clojure`           | 1.802 ± 0.011  |   1.781 |   1.819 |     89.94 ± 5.30 |
| `Dart`              | 0.541 ± 0.024  |   0.508 |   0.576 |     27.02 ± 2.00 |
| `Javascript (node)` | 0.622 ± 0.011  |   0.610 |   0.646 |     31.04 ± 1.90 |
| `Javascript (deno)` | 0.685 ± 0.010  |   0.678 |   0.706 |     34.20 ± 2.07 |
| `Julia`             | 0.525 ± 0.003  |   0.519 |   0.531 |     26.23 ± 1.55 |
| `Lua`               | 0.390 ± 0.062  |   0.327 |   0.463 |     19.49 ± 3.29 |
| `Php`               | 3.301 ± 0.018  |   3.274 |   3.337 |    164.77 ± 9.71 |
| `Perl`              | 30.766 ± 0.234 |  30.473 |  31.322 |  1535.85 ± 90.88 |
| `Raku(Perl6)`       | 77.330 ± 3.933 |  71.032 |  81.773 | 3860.36 ± 299.77 |
| `Python`            | 18.937 ± 0.302 |  18.419 |  19.449 |   945.33 ± 57.49 |
| `Ruby`              | 7.236 ± 0.058  |   7.168 |   7.331 |   361.25 ± 21.40 |
| `Vimscript(NeoVim)` | 0.020 ± 0.001  |   0.018 |   0.022 |             1.00 |
| `Vimscript(Vim)`    | 2.011 ± 0.001  |   2.010 |   2.012 |    100.38 ± 5.89 |
| `Vimscript9`        | 2.010 ± 0.000  |   2.010 |   2.011 |    100.36 ± 5.89 |

## Shell

| Language |    Mean [s]    | Min [s] | Max [s] |          Relative |
| :------- | :------------: | ------: | ------: | ----------------: | 
| `Bash*`  | 11.792 ± 0.096 |  11.611 |  11.952 | 9399.19 ± 2268.42 |
| `Dash`   | 0.001 ± 0.000  |   0.001 |   0.002 |              1.00 |
| `Ion`    | 0.002 ± 0.000  |   0.002 |   0.003 |       1.78 ± 0.54 |
| `Oil`    | 0.083 ± 0.001  |   0.082 |   0.084 |     66.07 ± 15.94 |

## WASM

| Language   |   Mean [s]    | Min [s] | Max [s] |    Relative |
| :--------- | :-----------: | ------: | ------: | ----------: | 
| `Wasmer`   | 0.339 ± 0.077 |   0.263 |   0.438 | 1.04 ± 0.24 |
| `Wasmtime` | 0.324 ± 0.006 |   0.321 |   0.340 |        1.00 |

### Note
###### * Bash only calculates the fibonacci sequence to the 20th term (so that it will finish)
######  Vimscript(9) time includes the time taken to startup (neo)vim