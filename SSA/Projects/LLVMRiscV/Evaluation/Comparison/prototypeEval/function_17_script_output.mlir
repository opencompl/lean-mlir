{
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i1):
    %0 = "llvm.xor"(%arg0, %arg1) : (i64, i64) -> i64
    %1 = "llvm.zext"(%arg2) : (i1) -> i64
    %2 = "llvm.shl"(%1, %0) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %3 = "llvm.xor"(%2, %2) : (i64, i64) -> i64
    %4 = "llvm.mul"(%0, %3) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
}
