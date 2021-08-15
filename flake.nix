{

    inputs = {
        flake-compat = {
            url = "github:edolstra/flake-compat";
            flake = false;
        };
        nixpkgs.url = "nixpkgs/nixos-unstable";
        utils.url = "github:numtide/flake-utils";
        rust-overlay.url = "github:oxalica/rust-overlay";
        devshell.url = "github:numtide/devshell";
    };

    outputs = { self, utils, devshell, nixpkgs, rust-overlay, flake-compat, ... }:
        utils.lib.eachDefaultSystem (system:
        let
            pkgs = import nixpkgs {
                inherit system;
                overlays = [ 
                    devshell.overlay 
                    rust-overlay.overlay 
                ];
            };

            rust-nightly = pkgs.rust-bin.nightly."2021-08-12".default.override {
                extensions = [
                    "cargo"
                    "clippy"
                    "rust-docs"
                    "rust-src"
                    "rust-std"
                    "rustc"
                    "rustfmt"
                ];
                targets = [
                    "wasm32-unknown-unknown"
                    "wasm32-wasi"
                ];
            };

            bench = pkgs.writers.writePython3Bin "benchmarkLangs" {
    libraries = [ pkgs.python39Packages.pyyaml ];
    flakeIgnore = [ "E501" ];
} ''
import subprocess
import os
import shutil

ROOT_DIR = os.getenv("DEVSHELL_ROOT")
date = os.system('date "+%A, %B %d @ %I:%M%p %Z"')
native = f"{ROOT_DIR}/native/fib."
n_fib = f"{ROOT_DIR}/fib"
interpreted = f"{ROOT_DIR}/interpreted/fib."
shell = f"{ROOT_DIR}/shell/fib."
wasm = f"{ROOT_DIR}/wasm/fib."


def lang_header(header):
    os.system(f"echo -e \"\n## {header}\n\" >> readme.md")
    os.system('echo -e "| Language | Mean [s] | Min [s] | Max [s] | Relative |" >> readme.md')
    os.system('echo -e "|:---|:---:|---:|---:|---:|" >> readme.md')


def run_bench(langDict, header):
    langs = len(langDict)
    templ = [
        "${pkgs.hyperfine}/bin/hyperfine",
        "--warmup=2",
        "--runs=10",
        "--time-unit=second",
        f"--export-markdown={ROOT_DIR}/tmp_bench.md",
    ]

    for lang, executor in langDict.items():
        templ.append(f"--command-name={lang}")
        templ.append(f"{executor}")

    subprocess.run(
        templ,
        capture_output=False,
    )

    lang_header(header)
    os.system(f"cat tmp_bench.md | tail -n{langs}  >> readme.md")


nativeLang = {
    "C": f"${pkgs.gcc}/bin/gcc -fno-inline-small-functions -O3 -o {n_fib}C {native}c",
    "C++": f"${pkgs.gcc}/bin/g++ -fno-inline-small-functions -O3 -o {n_fib}C++ {native}cpp",
    "D": f"${pkgs.ldc}/bin/ldc2  -O3 -release -of={n_fib}D {native}d",
    "Go": f"${pkgs.go}/bin/go build -o {n_fib}Go {native}go",
    "Lisp": f"${pkgs.sbcl}/bin/sbcl --load {native}lisp",
    "Nim": f"${pkgs.nim}/bin/nim c -d:danger --passC:-fno-inline-small-functions -o={n_fib}Nim {native}nim",
    "Rust": f"${rust-nightly}/bin/rustc -C opt-level=3 -o {n_fib}Rust {native}rs",
    "V": f"${pkgs.vlang}/bin/v -cflags -fno-inline-small-functions -prod -o {n_fib}V {native}v",
    "Zig": f"${pkgs.zig}/bin/zig build-exe -O ReleaseFast {native}zig --name fibZig"
}

interpretedLang = {
    "Clojure": f"${pkgs.clojure}/bin/clojure -M {interpreted}cljc",
    "Dart": f"${pkgs.dart}/bin/dart {interpreted}dart",
    "Javascript (node)": f"${pkgs.nodejs}/bin/node {interpreted}js",
    "Javascript (deno)": f"${pkgs.deno}/bin/deno run {interpreted}js",
    "Julia": f"${pkgs.julia-stable-bin}/bin/julia {interpreted}jl",
    "Lua": f"${pkgs.luajit}/bin/lua {interpreted}lua",
    "Php": f"${pkgs.php}/bin/php {interpreted}php",
    "Perl": f"${pkgs.perl}/bin/perl {interpreted}pl",
    "Raku(Perl6)": f"${pkgs.rakudo}/bin/raku {interpreted}p6",
    "Python": f"${pkgs.python39}/bin/python {interpreted}py",
    "Ruby": f"${pkgs.ruby}/bin/ruby {interpreted}rb",
    "Vimscript(NeoVim)": f"${pkgs.neovim}/bin/nvim -u NONE --clean -S {interpreted}vim --cmd 'quit'",
    "Vimscript(Vim)": f"${pkgs.vim}/bin/vim -u NONE --clean -S {interpreted}vim --cmd 'quit'",
    "Vimscript9": f"${pkgs.vim}/bin/vim -u NONE --clean -S {interpreted}vim9 --cmd 'quit'"
}

shellLang = {
    "Bash*": f"${pkgs.bash}/bin/bash {shell}bash",
    "Dash": f"${pkgs.dash}/bin/dash {shell}dash",
    "Ion": f"${pkgs.ion}/bin/ion {shell}ion",
    "Oil": f"${pkgs.oil}/bin/oil {shell}oil",
}

wasmRuntimes = {
    "Wasmer": f"${pkgs.wasmer}/bin/wasmer {ROOT_DIR}/fib.wasm",
    "Wasmtime": f"${pkgs.wasmtime}/bin/wasmtime {ROOT_DIR}/fib.wasm"
}


header = f""" # Language Benchmark
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

Last benchmark was ran on {date}
"""

os.system(f"echo -e \"{header}\" > readme.md")

nativeRun = {}
for lang, executor in nativeLang.items():
    print(f"Building fib for {lang}")
    os.system(executor)
    print("Build complete")
    nativeRun = {}
    for key in nativeLang.keys():
        nativeRun[key] = f"./fib{lang}"

run_bench(nativeRun, "Natively Compiled")
run_bench(interpretedLang, "Interpreted")
run_bench(shellLang, "Shell")

print("Building fib for WASM")
os.system(f"${rust-nightly}/bin/rustc -C opt-level=3 --target wasm32-wasi -o {n_fib}.wasm {wasm}rs")
print("Build complete")

run_bench(wasmRuntimes, "WASM")

os.system('echo -e "\n### Notes" >> readme.md')
os.system('echo -e "\n###### * Bash only calculates the fibonacci sequence to the 20th term (so that it will finish)" >> readme.md')
os.system('echo -e "\n######  Vimscript(9) time includes the time taken to startup (neo)vim" >> readme.md')

# Clean up
for lang, executor in nativeLang.items():
    os.remove(f"{ROOT_DIR}/fib{lang}")

os.remove(f"{ROOT_DIR}/fibD.o")
os.remove(f"{ROOT_DIR}/fib.wasm")
shutil.rmtree(f"{ROOT_DIR}/native/zig-cache")
os.remove(f"{ROOT_DIR}/tmp_bench.md")
'';

        in {
            # nix develop
            devShell = pkgs.devshell.mkShell {
                name = "langPerf";

                # Custom scripts. Also easy to use them in CI/CD
                commands = [

                    {
                        name = "b";
                        help = "Benchmark";
                        command = "${bench}/bin/benchmarkLangs";
                    }
                    {
                        name = "code";
                        help = "Open vscodium";
                        command = "${pkgs.vscodium}/bin/codium $DEVSHELL_ROOT";
                    }
                ];

                packages = with pkgs;[
                    # For benchmarking 
                    hyperfine
                    bench

                    # For native languages
                    gcc
                    go
                    rust-nightly
                    sbcl
                    vlang
                    nim
                    ldc
                    zig

                    # For interpreted languages
                    julia-stable-bin
                    luajit
                    php
                    perl
                    rakudo
                    python3Full
                    ruby_3_0
                    nodejs
                    dart
                    deno
                    clojure

                    # For shells
                    bash
                    dash
                    ion
                    nushell
                    oil

                    # wasm
                    wasmtime
                    wasmer
                    ];
                env = [
                    {name = "NIGHTLY_PATH"; eval = "${rust-nightly}";}

                ];
            };
        });
}
