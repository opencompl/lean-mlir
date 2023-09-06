module  {
  llvm.func @PR56424(%arg0: i1, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(-81 : i64) : i64
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%2 : i64)
  ^bb1:  // pred: ^bb0
    %3 = llvm.ashr %arg1, %1  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.br ^bb2(%4 : i64)
  ^bb2(%5: i64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.and %0, %5  : i64
    llvm.return %6 : i64
  }
}
