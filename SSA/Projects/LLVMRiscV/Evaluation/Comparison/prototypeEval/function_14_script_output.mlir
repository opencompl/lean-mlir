{
  ^bb0(%arg0: i64):
    %0 = "llvm.icmp"(%arg0, %arg0) <{predicate = 6 : i64}> : (i64, i64) -> i1
    %1 = "llvm.sext"(%0) : (i1) -> i64
    %2 = "llvm.icmp"(%1, %arg0) <{predicate = 4 : i64}> : (i64, i64) -> i1
    "llvm.return"(%2) : (i1) -> ()
}
