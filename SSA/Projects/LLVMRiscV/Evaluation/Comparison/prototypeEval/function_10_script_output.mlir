{
  ^bb0(%arg0: i64):
    %0 = "llvm.trunc"(%arg0) <{overflowFlags = #llvm.overflow<none>}> : (i64) -> i1
    "llvm.return"(%0) : (i1) -> ()
}
