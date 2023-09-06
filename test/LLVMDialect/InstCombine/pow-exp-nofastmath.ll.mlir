module  {
  llvm.func @mypow(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.pow.f64(%0, %arg1) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @exp(f64) -> f64
  llvm.func @llvm.pow.f64(f64, f64) -> f64
}
