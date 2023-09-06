module  {
  llvm.func @llvm.sqrt.f64(f64) -> f64
  llvm.func @llvm.sqrt.v2f32(vector<2xf32>) -> vector<2xf32>
  llvm.func @use(f64)
  llvm.func @sqrt_a_sqrt_b(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.sqrt.f64(%arg1) : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_a_sqrt_b_multiple_uses(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.sqrt.f64(%arg1) : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @sqrt_a_sqrt_b_reassoc_nnan(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.sqrt.f64(%arg1) : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_a_sqrt_b_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.sqrt.f64(%arg1) : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.sqrt.f64(%arg1) : (f64) -> f64
    %2 = llvm.call @llvm.sqrt.f64(%arg2) : (f64) -> f64
    %3 = llvm.call @llvm.sqrt.f64(%arg3) : (f64) -> f64
    %4 = llvm.fmul %0, %1  : f64
    %5 = llvm.fmul %4, %2  : f64
    %6 = llvm.fmul %5, %3  : f64
    llvm.return %6 : f64
  }
  llvm.func @rsqrt_squared(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fmul %2, %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @rsqrt_x_reassociate_extra_use(%arg0: f64, %arg1: !llvm.ptr<f64>) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fmul %2, %arg0  : f64
    llvm.store %2, %arg1 : !llvm.ptr<f64>
    llvm.return %3 : f64
  }
  llvm.func @x_add_y_rsqrt_reassociate_extra_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: !llvm.ptr<vector<2xf32>>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fadd %arg0, %arg1  : vector<2xf32>
    %2 = llvm.call @llvm.sqrt.v2f32(%1) : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fdiv %0, %2  : vector<2xf32>
    %4 = llvm.fmul %1, %3  : vector<2xf32>
    llvm.store %3, %arg2 : !llvm.ptr<vector<2xf32>>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @sqrt_divisor_squared(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    %1 = llvm.fdiv %arg1, %0  : f64
    %2 = llvm.fmul %1, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_dividend_squared(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.call @llvm.sqrt.v2f32(%arg0) : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fdiv %0, %arg1  : vector<2xf32>
    %2 = llvm.fmul %1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @sqrt_divisor_squared_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    %1 = llvm.fdiv %arg1, %0  : f64
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fmul %1, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_dividend_squared_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fdiv %0, %arg1  : f64
    %2 = llvm.fmul %1, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_divisor_not_enough_FMF(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    %1 = llvm.fdiv %arg1, %0  : f64
    %2 = llvm.fmul %1, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @rsqrt_squared_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @llvm.sqrt.f64(%arg0) : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.call @use(%2) : (f64) -> ()
    %3 = llvm.fmul %2, %2  : f64
    llvm.return %3 : f64
  }
}
