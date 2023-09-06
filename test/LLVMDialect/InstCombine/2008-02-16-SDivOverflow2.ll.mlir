module  {
  llvm.func @i(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    %2 = llvm.sdiv %1, %0  : i8
    llvm.return %2 : i8
  }
}
