module  {
  llvm.func @acos(f64) -> f64
  llvm.func @test_simplify_acos() -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_acos_nobuiltin() -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_acos_strictfp() -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
}
