{
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mul"(%arg0, %arg1) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %1 = "llvm.srem"(%0, %arg0) : (i64, i64) -> i64
    %2 = "llvm.srem"(%0, %1) : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
}
