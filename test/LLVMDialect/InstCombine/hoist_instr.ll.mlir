module  {
  llvm.func @foo(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.sdiv %2, %0  : i32
    llvm.return %3 : i32
  }
}
