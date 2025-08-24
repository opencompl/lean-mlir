{
  ^bb0(%arg0: i64):
    %0 = "llvm.trunc"(%arg0) <{overflowFlags = #llvm.overflow<nsw>}> : (i64) -> i1
    %1 = "llvm.sext"(%0) : (i1) -> i64
    "llvm.return"(%1) : (i64) -> ()
}
