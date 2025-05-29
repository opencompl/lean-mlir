  {
  ^bb0(%arg1: i64):
    %1 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "llvm.add"(%arg1, %arg1) <{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> i64
    %3 = "llvm.xor"(%2, %1) : (i64, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }