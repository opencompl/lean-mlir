module  {
  llvm.func @llvm.fabs.f64(f64) -> f64
  llvm.func @llvm.fabs.f32(f32) -> f32
  llvm.func @llvm.fabs.v4f64(vector<4xf64>) -> vector<4xf64>
  llvm.func @use(f64)
  llvm.func @llvm.copysign.f64(f64, f64) -> f64
  llvm.func @llvm.copysign.f32(f32, f32) -> f32
  llvm.func @fabs_copysign(%arg0: f64) -> f64 {
    %0 = llvm.call @llvm.fabs.f64(%arg0) : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_commuted(%arg0: f64) -> f64 {
    %0 = llvm.call @llvm.fabs.f64(%arg0) : (f64) -> f64
    %1 = llvm.fdiv %0, %arg0  : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_vec(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.call @llvm.fabs.v4f64(%arg0) : (vector<4xf64>) -> vector<4xf64>
    %1 = llvm.fdiv %arg0, %0  : vector<4xf64>
    llvm.return %1 : vector<4xf64>
  }
  llvm.func @fabs_copysign_vec_commuted(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.call @llvm.fabs.v4f64(%arg0) : (vector<4xf64>) -> vector<4xf64>
    %1 = llvm.fdiv %0, %arg0  : vector<4xf64>
    llvm.return %1 : vector<4xf64>
  }
  llvm.func @fabs_copysignf(%arg0: f32) -> f32 {
    %0 = llvm.call @llvm.fabs.f32(%arg0) : (f32) -> f32
    %1 = llvm.fdiv %arg0, %0  : f32
    llvm.return %1 : f32
  }
  llvm.func @fabs_copysign_use(%arg0: f64) -> f64 {
    %0 = llvm.call @llvm.fabs.f64(%arg0) : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fdiv %arg0, %0  : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_mismatch(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.fabs.f64(%arg1) : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_commuted_mismatch(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.fabs.f64(%arg1) : (f64) -> f64
    %1 = llvm.fdiv %0, %arg0  : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_no_nnan(%arg0: f64) -> f64 {
    %0 = llvm.call @llvm.fabs.f64(%arg0) : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  : f64
    llvm.return %1 : f64
  }
  llvm.func @fabs_copysign_no_ninf(%arg0: f64) -> f64 {
    %0 = llvm.call @llvm.fabs.f64(%arg0) : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  : f64
    llvm.return %1 : f64
  }
}
