{
  ^bb0(%arg0: i64):
    %0 = "llvm.lshr"(%arg0, %arg0) : (i64, i64) -> i64
    %1 = "llvm.icmp"(%arg0, %0) <{predicate = 7 : i64}> : (i64, i64) -> i1
    "llvm.return"(%1) : (i1) -> ()
}
