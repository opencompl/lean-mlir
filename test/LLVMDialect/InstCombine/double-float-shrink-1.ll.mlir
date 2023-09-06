module  {
  llvm.func @acos_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @acos_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @acosh_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acosh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @acosh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acosh(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @asin_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asin(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @asin_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @asinh_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asinh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @asinh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asinh(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @atan_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atan(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @atan_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atan(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @atanh_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atanh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @atanh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atanh(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @cbrt_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cbrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @cbrt_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cbrt(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @exp_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @exp(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @exp_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @exp(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @expm1_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @expm1(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @expm1_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @expm1(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @exp10_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @exp10(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @exp10_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @exp10(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @log_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @log_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @log10_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log10(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @log10_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log10(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @log1p_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log1p(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @log1p_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log1p(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @log2_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log2(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @log2_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @logb_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @logb(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @logb_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @logb(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_test1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @pow(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @pow_test2(%arg0: f32, %arg1: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @pow(%0, %1) : (f64, f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @sin_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @sin_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @sqrt_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_int_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @llvm.sqrt.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @sqrt_int_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @llvm.sqrt.f64(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @tan_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tan(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @tan_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tan(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @tanh_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tanh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @tanh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tanh(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @max1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmax(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @fake_fmin(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f128
    %1 = llvm.fpext %arg1 : f32 to f128
    %2 = llvm.call @fmin(%0, %1) : (f128, f128) -> f128
    %3 = llvm.fptrunc %2 : f128 to f32
    llvm.return %3 : f32
  }
  llvm.func @fmin(f128, f128) -> f128
  llvm.func @fmax(f64, f64) -> f64
  llvm.func @tanh(f64) -> f64
  llvm.func @tan(f64) -> f64
  llvm.func @sqrt(f64) -> f64
  llvm.func @llvm.sqrt.f64(f64) -> f64
  llvm.func @sin(f64) -> f64
  llvm.func @pow(f64, f64) -> f64
  llvm.func @log2(f64) -> f64
  llvm.func @log1p(f64) -> f64
  llvm.func @log10(f64) -> f64
  llvm.func @log(f64) -> f64
  llvm.func @logb(f64) -> f64
  llvm.func @exp10(f64) -> f64
  llvm.func @expm1(f64) -> f64
  llvm.func @exp(f64) -> f64
  llvm.func @cbrt(f64) -> f64
  llvm.func @atanh(f64) -> f64
  llvm.func @atan(f64) -> f64
  llvm.func @acos(f64) -> f64
  llvm.func @acosh(f64) -> f64
  llvm.func @asin(f64) -> f64
  llvm.func @asinh(f64) -> f64
}
