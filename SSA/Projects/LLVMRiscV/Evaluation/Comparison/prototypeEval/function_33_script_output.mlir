{
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.or"(%arg1, %arg0) : (i64, i64) -> i64
    %1 = "llvm.mul"(%arg0, %0) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %2 = "llvm.or"(%arg0, %1) : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
}
