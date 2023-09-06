module  {
  llvm.func @test1() -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @__sinpi(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test2() -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @__cospi(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @__sinpi(f64) -> f64
  llvm.func @__cospi(f64) -> f64
}
