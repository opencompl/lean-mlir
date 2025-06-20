{
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.or"(%arg0, %arg0) : (i64, i64) -> i64
    %1 = "llvm.sub"(%0, %arg1) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %2 = "llvm.and"(%1, %arg1) : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
}
