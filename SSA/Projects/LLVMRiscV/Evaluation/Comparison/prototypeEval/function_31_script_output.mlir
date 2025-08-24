{
  ^bb0(%arg0: i64, %arg1: i1, %arg2: i64):
    %0 = "llvm.select"(%arg1, %arg2, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %1 = "llvm.mul"(%0, %0) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %2 = "llvm.icmp"(%arg0, %1) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "llvm.return"(%2) : (i1) -> ()
}
