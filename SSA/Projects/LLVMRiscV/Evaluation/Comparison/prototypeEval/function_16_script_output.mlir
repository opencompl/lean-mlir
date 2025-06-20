{
  ^bb0(%arg0: i1, %arg1: i64, %arg2: i64):
    %0 = "llvm.zext"(%arg0) : (i1) -> i64
    %1 = "llvm.sdiv"(%0, %0) : (i64, i64) -> i64
    %2 = "llvm.srem"(%0, %1) : (i64, i64) -> i64
    %3 = "llvm.sub"(%1, %2) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %4 = "llvm.ashr"(%1, %3) : (i64, i64) -> i64
    %5 = "llvm.sdiv"(%4, %2) : (i64, i64) -> i64
    %6 = "llvm.select"(%arg0, %1, %5) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %7 = "llvm.add"(%arg1, %6) <{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> i64
    %8 = "llvm.add"(%7, %arg2) <{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> i64
    %9 = "llvm.xor"(%6, %8) : (i64, i64) -> i64
    "llvm.return"(%9) : (i64) -> ()
}
