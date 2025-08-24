{
  ^bb0(%arg0: i1):
    %0 = "llvm.zext"(%arg0) : (i1) -> i64
    %1 = "llvm.select"(%arg0, %0, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %2 = "llvm.trunc"(%1) <{overflowFlags = #llvm.overflow<nsw>}> : (i64) -> i1
    "llvm.return"(%2) : (i1) -> ()
}
