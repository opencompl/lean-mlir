module  {
  llvm.func @f() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(-29 : i32) : i32
    llvm.br ^bb1(%3 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.srem %4, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.cond_br %6, ^bb2, ^bb1(%0 : i32)
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  }
}
