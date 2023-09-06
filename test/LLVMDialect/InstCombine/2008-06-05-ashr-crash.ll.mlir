module  {
  llvm.func @foo(%arg0: i65) -> i65 {
    %0 = llvm.mlir.constant(65 : i65) : i65
    %1 = llvm.ashr %arg0, %0  : i65
    llvm.return %1 : i65
  }
}
