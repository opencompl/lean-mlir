module  {
  llvm.func @cast() -> f80 {
    %0 = llvm.mlir.constant(0 : i80) : i80
    %1 = llvm.bitcast %0 : i80 to f80
    llvm.return %1 : f80
  }
  llvm.func @invcast() -> i80 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f80
    %1 = llvm.bitcast %0 : f80 to i80
    llvm.return %1 : i80
  }
}
