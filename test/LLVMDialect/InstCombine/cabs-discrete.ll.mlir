module  {
  llvm.func @std_cabs(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @cabs(%arg0, %arg1) : (f64, f64) -> f64
    llvm.return %0 : f64
  }
  llvm.func @std_cabsf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @cabsf(%arg0, %arg1) : (f32, f32) -> f32
    llvm.return %0 : f32
  }
  llvm.func @std_cabsl(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @cabsl(%arg0, %arg1) : (f128, f128) -> f128
    llvm.return %0 : f128
  }
  llvm.func @fast_cabs(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @cabs(%arg0, %arg1) : (f64, f64) -> f64
    llvm.return %0 : f64
  }
  llvm.func @fast_cabsf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @cabsf(%arg0, %arg1) : (f32, f32) -> f32
    llvm.return %0 : f32
  }
  llvm.func @fast_cabsl(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @cabsl(%arg0, %arg1) : (f128, f128) -> f128
    llvm.return %0 : f128
  }
  llvm.func @cabs(f64, f64) -> f64
  llvm.func @cabsf(f32, f32) -> f32
  llvm.func @cabsl(f128, f128) -> f128
}
