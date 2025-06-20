{
  ^bb0(%arg0: i1):
    %0 = "llvm.sext"(%arg0) : (i1) -> i64
    %1 = "llvm.udiv"(%0, %0) : (i64, i64) -> i64
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> i64
    %3 = "llvm.trunc"(%2) <{overflowFlags = #llvm.overflow<none>}> : (i64) -> i1
    "llvm.return"(%3) : (i1) -> ()
}
