{
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
    %0 = "llvm.or"(%arg1, %arg2) : (i64, i64) -> i64
    %1 = "llvm.urem"(%arg0, %0) : (i64, i64) -> i64
    %2 = "llvm.or"(%1, %0) : (i64, i64) -> i64
    %3 = "llvm.icmp"(%2, %arg0) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %4 = "llvm.sext"(%3) : (i1) -> i64
    %5 = "llvm.icmp"(%2, %4) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "llvm.return"(%5) : (i1) -> ()
}
