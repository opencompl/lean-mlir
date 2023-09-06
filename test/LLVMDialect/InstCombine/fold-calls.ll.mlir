module  {
  llvm.func @foo() -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @bar() -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sin(f64) -> f64
}
