module  {
  llvm.func @mylog(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test3(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @log(f64) -> f64
  llvm.func @exp2(f64) -> f64
  llvm.func @llvm.pow.f64(f64, f64) -> f64
}
