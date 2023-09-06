module  {
  llvm.mlir.global common @b(0 : i32) : i32
  llvm.func @fn1() -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.addressof @b : !llvm.ptr<i32>
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.addressof @b : !llvm.ptr<i32>
    %6 = llvm.load %5 : !llvm.ptr<i32>
    llvm.br ^bb1(%6, %4 : i32, i32)
  ^bb1(%7: i32, %8: i32):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.lshr %7, %3  : i32
    %10 = llvm.or %9, %7  : i32
    %11 = llvm.add %8, %3  : i32
    %12 = llvm.icmp "eq" %11, %2 : i32
    llvm.cond_br %12, ^bb2, ^bb1(%10, %11 : i32, i32)
  ^bb2:  // pred: ^bb1
    llvm.store %10, %1 : !llvm.ptr<i32>
    llvm.return %0 : i32
  }
}
