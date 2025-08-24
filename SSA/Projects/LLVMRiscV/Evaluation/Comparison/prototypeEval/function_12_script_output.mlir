{
  ^bb0(%arg0: i64, %arg1: i1, %arg2: i64):
    %0 = "llvm.select"(%arg1, %arg2, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %1 = "llvm.mul"(%arg0, %0) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %2 = "llvm.ashr"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.icmp"(%2, %2) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %4 = "llvm.sext"(%3) : (i1) -> i64
    "llvm.return"(%4) : (i64) -> ()
}
