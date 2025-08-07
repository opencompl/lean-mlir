{
  ^bb0(%arg5: i64, %arg6: i64):
    %3 = "llvm.icmp"(%arg5, %arg6) <{predicate = 0 : i64}> : (i64, i64) -> i1
    %4 = "llvm.icmp"(%arg5, %arg6) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %5 = "llvm.icmp"(%arg5, %arg6) <{predicate = 8 : i64}> : (i64, i64) -> i1
    %6 = "llvm.icmp"(%arg5, %arg6) <{predicate = 9 : i64}> : (i64, i64) -> i1
    %7 = "llvm.icmp"(%arg5, %arg6) <{predicate = 6 : i64}> : (i64, i64) -> i1
    %8 = "llvm.icmp"(%arg5, %arg6) <{predicate = 7 : i64}> : (i64, i64) -> i1
    %9 = "llvm.icmp"(%arg5, %arg6) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %10 = "llvm.icmp"(%arg5, %arg6) <{predicate = 5 : i64}> : (i64, i64) -> i1
    %11 = "llvm.icmp"(%arg5, %arg6) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %12 = "llvm.icmp"(%arg5, %arg6) <{predicate = 3 : i64}> : (i64, i64) -> i1
    "llvm.return"(%4) : (i1) -> ()
}
