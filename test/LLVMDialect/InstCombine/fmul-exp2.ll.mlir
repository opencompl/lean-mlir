module  {
  llvm.func @llvm.exp2.f64(f64) -> f64
  llvm.func @use(f64)
  llvm.func @exp2_a_exp2_b(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.exp2.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.exp2.f64(%arg1) : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @exp2_a_exp2_b_multiple_uses(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.exp2.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.exp2.f64(%arg1) : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @exp2_a_a(%arg0: f64) -> f64 {
    %0 = llvm.call @llvm.exp2.f64(%arg0) : (f64) -> f64
    %1 = llvm.fmul %0, %0  : f64
    llvm.return %1 : f64
  }
  llvm.func @exp2_a_exp2_b_multiple_uses_both(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.exp2.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.exp2.f64(%arg1) : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @exp2_a_exp2_b_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.exp2.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.exp2.f64(%arg1) : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @exp2_a_exp2_b_exp2_c_exp2_d(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = llvm.call @llvm.exp2.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.exp2.f64(%arg1) : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    %3 = llvm.call @llvm.exp2.f64(%arg2) : (f64) -> f64
    %4 = llvm.fmul %2, %3  : f64
    %5 = llvm.call @llvm.exp2.f64(%arg3) : (f64) -> f64
    %6 = llvm.fmul %4, %5  : f64
    llvm.return %6 : f64
  }
}
