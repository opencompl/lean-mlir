module  {
  llvm.func @fabs(f64) -> f64
  llvm.func @test(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg0, %0  : f64
    %2 = llvm.fadd %1, %0  : f64
    llvm.return %2 : f64
  }
  llvm.func @test1(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @fabs(%arg0) : (f64) -> f64
    %2 = llvm.fadd %1, %0  : f64
    llvm.return %2 : f64
  }
}
