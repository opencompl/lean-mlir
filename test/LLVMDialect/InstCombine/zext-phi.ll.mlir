module  {
  llvm.func @sink_i1_casts(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i64)
  ^bb1:  // pred: ^bb0
    %1 = llvm.zext %arg1 : i1 to i64
    llvm.br ^bb2(%1 : i64)
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i64
  }
}
