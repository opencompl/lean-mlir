module  {
  llvm.func @pow(f64, f64) -> f32
  llvm.func @test_no_simplify1(%arg0: f64) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f32
    llvm.return %1 : f32
  }
}
