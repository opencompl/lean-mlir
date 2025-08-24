{
  ^bb0(%arg0: i64, %arg1: i1):
    %0 = "llvm.sext"(%arg1) : (i1) -> i64
    %1 = "llvm.mul"(%arg0, %0) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %2 = "llvm.xor"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.or"(%arg0, %2) : (i64, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
}
