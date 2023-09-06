module  {
  llvm.func @d(%arg0: !llvm.ptr<i16>, %arg1: !llvm.ptr<i16>) -> i16 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.load %arg0 : !llvm.ptr<i16>
    %5 = llvm.icmp "ne" %4, %3 : i16
    llvm.cond_br %5, ^bb1, ^bb2(%2 : i1)
  ^bb1:  // pred: ^bb0
    %6 = llvm.load %arg1 : !llvm.ptr<i16>
    %7 = llvm.icmp "ult" %6, %3 : i16
    llvm.br ^bb2(%7 : i1)
  ^bb2(%8: i1):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.zext %8 : i1 to i16
    %10 = llvm.mul %9, %1  : i16
    %11 = llvm.xor %10, %0  : i16
    llvm.return %11 : i16
  }
}
