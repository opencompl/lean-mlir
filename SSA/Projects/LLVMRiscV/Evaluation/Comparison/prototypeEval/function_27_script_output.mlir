{
  ^bb0(%arg0: i64):
    %0 = "llvm.mul"(%arg0, %arg0) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    "llvm.return"(%0) : (i64) -> ()
}
