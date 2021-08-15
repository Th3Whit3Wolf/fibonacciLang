const std = @import("std");

fn fib(n: u64) u64 {
    return if (n < 2) n else fib(n - 1) + fib(n - 2);
}

pub fn main() void {
    std.debug.print("{}\n",.{fib(@as(u64,40))});    
}