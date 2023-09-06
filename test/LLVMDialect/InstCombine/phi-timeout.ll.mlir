module  {
  llvm.func @timeout(%arg0: !llvm.ptr<i16>) {
    %0 = llvm.mlir.undef : !llvm.ptr<i8>
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(2 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %4 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i16>, i32) -> !llvm.ptr<i16>
    %5 = llvm.load %4 : !llvm.ptr<i16>
    %6 = llvm.icmp "eq" %5, %2 : i16
    llvm.cond_br %6, ^bb2, ^bb3(%5 : i16)
  ^bb2:  // pred: ^bb1
    %7 = llvm.load %4 : !llvm.ptr<i16>
    llvm.br ^bb3(%7 : i16)
  ^bb3(%8: i16):  // 2 preds: ^bb1, ^bb2
    %9 = llvm.trunc %8 : i16 to i8
    %10 = llvm.add %9, %1  : i8
    llvm.store %10, %0 : !llvm.ptr<i8>
    llvm.br ^bb1
  }
}
