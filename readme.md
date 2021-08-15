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

Last benchmark was ran on Sunday, August 15 @ 11:25PM BST


## Natively Compiled

| Language            |    Mean [s]    | Min [s] | Max [s] |         Relative |
| :------------------ | :------------: | ------: | ------: | ---------------: |
| `C` | 0.293 ± 0.006 | 0.286 | 0.301 | 1.01 ± 0.02 |
| `C++` | 0.290 ± 0.005 | 0.283 | 0.300 | 1.00 ± 0.02 |
| `D` | 0.291 ± 0.005 | 0.285 | 0.299 | 1.01 ± 0.02 |
| `Go` | 0.291 ± 0.008 | 0.286 | 0.309 | 1.01 ± 0.03 |
| `Lisp` | 0.291 ± 0.006 | 0.285 | 0.302 | 1.01 ± 0.02 |
| `Nim` | 0.290 ± 0.003 | 0.286 | 0.294 | 1.01 ± 0.01 |
| `Rust` | 0.291 ± 0.003 | 0.288 | 0.296 | 1.01 ± 0.01 |
| `V` | 0.288 ± 0.002 | 0.285 | 0.292 | 1.00 |
| `Zig` | 0.291 ± 0.005 | 0.286 | 0.301 | 1.01 ± 0.02 |

## Interpreted

| Language            |    Mean [s]    | Min [s] | Max [s] |         Relative |
| :------------------ | :------------: | ------: | ------: | ---------------: |
| `Clojure` | 1.782 ± 0.018 | 1.759 | 1.811 | 4.30 ± 0.62 |
| `Dart` | 0.517 ± 0.010 | 0.505 | 0.536 | 1.25 ± 0.18 |
| `Javascript (node)` | 0.615 ± 0.011 | 0.607 | 0.633 | 1.49 ± 0.21 |
| `Javascript (deno)` | 0.676 ± 0.006 | 0.671 | 0.692 | 1.63 ± 0.23 |
| `Julia` | 0.514 ± 0.006 | 0.504 | 0.523 | 1.24 ± 0.18 |
| `Lua` | 0.414 ± 0.059 | 0.321 | 0.462 | 1.00 |
| `Php` | 3.297 ± 0.046 | 3.267 | 3.404 | 7.96 ± 1.14 |
| `Perl` | 30.775 ± 0.195 | 30.435 | 31.009 | 74.30 ± 10.63 |
| `Raku(Perl6)` | 78.000 ± 5.188 | 71.547 | 87.189 | 188.32 ± 29.69 |
| `Python` | 18.946 ± 0.302 | 18.417 | 19.435 | 45.74 ± 6.58 |
| `Ruby` | 7.182 ± 0.035 | 7.116 | 7.228 | 17.34 ± 2.48 |
| `Vimscript` | 2.011 ± 0.001 | 2.010 | 2.011 | 4.85 ± 0.69 |
| `Vimscript9` | 2.011 ± 0.001 | 2.010 | 2.012 | 4.85 ± 0.69 |

## Shell

| Language            |    Mean [s]    | Min [s] | Max [s] |         Relative |
| :------------------ | :------------: | ------: | ------: | ---------------: |
| `Bash*` | 11.676 ± 0.070 | 11.559 | 11.778 | 6887.96 ± 1942.98 |
| `Dash` | 0.002 ± 0.000 | 0.001 | 0.003 | 1.00 |
| `Ion` | 0.002 ± 0.001 | 0.001 | 0.003 | 1.23 ± 0.48 |
| `Oil` | 0.084 ± 0.001 | 0.082 | 0.086 | 49.39 ± 13.94 |

## WASM

| Language            |    Mean [s]    | Min [s] | Max [s] |         Relative |
| :------------------ | :------------: | ------: | ------: | ---------------: |
| `Wasmer` | 0.328 ± 0.078 | 0.258 | 0.438 | 1.01 ± 0.24 |
| `Wasmtime` | 0.324 ± 0.002 | 0.321 | 0.329 | 1.00 |

### Notes

###### * Bash only calculates the fibonacci sequence to the 20th term (so that it will finish)

######  Vimscript(9) time includes the time taken to startup (neo)vim
