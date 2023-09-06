module  {
  llvm.func @fuzz15217(%arg0: i1, %arg1: !llvm.ptr<i8>, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(170141183460469231731687303715884105727 : i128) : i128
    %1 = llvm.mlir.constant(64 : i128) : i128
    %2 = llvm.mlir.constant(18446744073709551616 : i128) : i128
    %3 = llvm.mlir.constant(0 : i128) : i128
    llvm.cond_br %arg0, ^bb2(%3 : i128), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%2 : i128)
  ^bb2(%4: i128):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.lshr %4, %1  : i128
    %6 = llvm.lshr %5, %0  : i128
    %7 = llvm.trunc %6 : i128 to i64
    llvm.return %7 : i64
  }
}
