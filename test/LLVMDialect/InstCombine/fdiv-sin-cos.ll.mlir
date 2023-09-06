module  {
  llvm.func @fdiv_sin_cos(%arg0: f64) -> f64 {
    %0 = llvm.call @llvm.sin.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.cos.f64(%arg0) : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_strict_sin_strict_cos_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.call @llvm.sin.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.cos.f64(%arg0) : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_reassoc_sin_strict_cos_strict(%arg0: f64, %arg1: !llvm.ptr<i32>) -> f64 {
    %0 = llvm.call @llvm.sin.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.cos.f64(%arg0) : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_reassoc_sin_reassoc_cos_strict(%arg0: f64) -> f64 {
    %0 = llvm.call @llvm.sin.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.cos.f64(%arg0) : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_sin_cos_reassoc_multiple_uses(%arg0: f64) -> f64 {
    %0 = llvm.call @llvm.sin.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.cos.f64(%arg0) : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @fdiv_sin_cos_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.call @llvm.sin.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.cos.f64(%arg0) : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_sinf_cosf_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.call @llvm.sin.f32(%arg0) : (f32) -> f32
    %1 = llvm.call @llvm.cos.f32(%arg0) : (f32) -> f32
    %2 = llvm.fdiv %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_sinfp128_cosfp128_reassoc(%arg0: f128) -> f128 {
    %0 = llvm.call @llvm.sin.f128(%arg0) : (f128) -> f128
    %1 = llvm.call @llvm.cos.f128(%arg0) : (f128) -> f128
    %2 = llvm.fdiv %0, %1  : f128
    llvm.return %2 : f128
  }
  llvm.func @llvm.sin.f64(f64) -> f64
  llvm.func @llvm.sin.f32(f32) -> f32
  llvm.func @llvm.cos.f64(f64) -> f64
  llvm.func @llvm.cos.f32(f32) -> f32
  llvm.func @use(f64)
  llvm.func @llvm.sin.f128(f128) -> f128
  llvm.func @llvm.cos.f128(f128) -> f128
}
