module  {
  llvm.func @acos(f64) -> f64
  llvm.func @float_acos(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @asin(f64) -> f64
  llvm.func @float_asin(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asin(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @atan(f64) -> f64
  llvm.func @float_atan(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atan(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @atan2(f64, f64) -> f64
  llvm.func @float_atan2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @atan2(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @ceil(f64) -> f64
  llvm.func @float_ceil(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @ceil(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @_copysign(f64) -> f64
  llvm.func @float_copysign(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @_copysign(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @cos(f64) -> f64
  llvm.func @float_cos(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @cosh(f64) -> f64
  llvm.func @float_cosh(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cosh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @exp(f64, f64) -> f64
  llvm.func @float_exp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @exp(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @fabs(f64, f64) -> f64
  llvm.func @float_fabs(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fabs(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @floor(f64) -> f64
  llvm.func @float_floor(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @floor(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @fmod(f64, f64) -> f64
  llvm.func @float_fmod(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmod(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @log(f64) -> f64
  llvm.func @float_log(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @logb(f64) -> f64
  llvm.func @float_logb(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @logb(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @pow(f64, f64) -> f64
  llvm.func @float_pow(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @pow(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @sin(f64) -> f64
  llvm.func @float_sin(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @sinh(f64) -> f64
  llvm.func @float_sinh(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sinh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @sqrt(f64) -> f64
  llvm.func @float_sqrt(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @tan(f64) -> f64
  llvm.func @float_tan(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tan(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @tanh(f64) -> f64
  llvm.func @float_tanh(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tanh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @round(f64) -> f64
  llvm.func @float_round(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @round(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @powf(f32, f32) -> f32
  llvm.func @float_powsqrt(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
}
