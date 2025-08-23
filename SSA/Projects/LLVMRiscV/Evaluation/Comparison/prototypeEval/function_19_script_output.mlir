{
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mul"(%arg0, %arg0) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %1 = "llvm.urem"(%0, %arg1) : (i64, i64) -> i64
    "llvm.return"(%1) : (i64) -> ()
}
