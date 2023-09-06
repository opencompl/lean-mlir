module  {
  llvm.func @fast_div_201(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.mlir.constant(71 : i16) : i16
    %4 = llvm.zext %arg0 : i8 to i16
    %5 = llvm.mul %4, %3  : i16
    %6 = llvm.lshr %5, %2  : i16
    %7 = llvm.trunc %6 : i16 to i8
    %8 = llvm.sub %arg0, %7  : i8
    %9 = llvm.lshr %8, %1  : i8
    %10 = llvm.add %7, %9  : i8
    %11 = llvm.lshr %10, %0  : i8
    llvm.return %11 : i8
  }
}
