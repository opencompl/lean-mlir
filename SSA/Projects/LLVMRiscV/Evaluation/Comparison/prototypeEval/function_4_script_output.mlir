{
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.sdiv"(%arg1, %arg0) : (i64, i64) -> i64
    %1 = "llvm.icmp"(%arg1, %0) <{predicate = 3 : i64}> : (i64, i64) -> i1
    %2 = "llvm.zext"(%1) : (i1) -> i64
    %3 = "llvm.icmp"(%arg0, %2) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "llvm.return"(%3) : (i1) -> ()
}
