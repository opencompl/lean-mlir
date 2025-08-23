{
  ^bb0(%arg0: i64):
    %0 = "llvm.or"(%arg0, %arg0) : (i64, i64) -> i64
    %1 = "llvm.trunc"(%0) <{overflowFlags = #llvm.overflow<none>}> : (i64) -> i1
    "llvm.return"(%1) : (i1) -> ()
}
