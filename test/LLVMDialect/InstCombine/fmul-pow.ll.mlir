module  {
  llvm.func @llvm.pow.f64(f64, f64) -> f64
  llvm.func @use(f64)
  llvm.func @pow_ab_a(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.fmul %0, %arg0  : f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ab_a_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.fmul %0, %arg0  : f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ab_a_reassoc_commute(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  : f64
    %2 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @pow_ab_pow_cb(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @llvm.pow.f64(%arg2, %arg1) : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_pow_cb_reassoc(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @llvm.pow.f64(%arg2, %arg1) : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_pow_ac(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %arg2) : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_x_pow_ac_reassoc(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %arg2) : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.fmul %0, %0  : f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ab_reassoc_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.fmul %0, %0  : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }
  llvm.func @pow_ab_x_pow_ac_reassoc_extra_use(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %arg2) : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @pow_ab_x_pow_ac_reassoc_multiple_uses(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.call @llvm.pow.f64(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %arg2) : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
}
