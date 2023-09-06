module  {
  llvm.func @test(%arg0: f64) -> f64 {
    %0 = llvm.fsub %arg0, %arg0  : f64
    llvm.return %0 : f64
  }
}
