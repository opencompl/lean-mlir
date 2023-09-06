module  {
  llvm.func @pow_libcall_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_libcall_half_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_half_approx(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.call @llvm.pow.v2f64(%arg0, %0) : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @powf_intrinsic_half_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @llvm.pow.f32(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_half_no_FMF_base_ninf(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.call @pow(%1, %0) : (f64, f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @pow_libcall_half_ninf(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_half_ninf(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.call @llvm.pow.v2f64(%arg0, %0) : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow_libcall_half_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_half_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_libcall_half_ninf_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_half_ninf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_libcall_half_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_half_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_libcall_neghalf_no_FMF(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_neghalf_reassoc_ninf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_neghalf_afn(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_neghalf_no_FMF(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.call @llvm.pow.v2f64(%arg0, %0) : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow_intrinsic_neghalf_reassoc(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.call @llvm.pow.v2f64(%arg0, %0) : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow_intrinsic_neghalf_afn(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.call @llvm.pow.v2f64(%arg0, %0) : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow_libcall_neghalf_ninf(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_neghalf_ninf(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.call @llvm.pow.v2f64(%arg0, %0) : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow_libcall_neghalf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_neghalf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_intrinsic_neghalf_ninf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_libcall_neghalf_ninf_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_neghalf_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_neghalf_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @llvm.pow.f64(f64, f64) -> f64
  llvm.func @llvm.pow.f32(f32, f32) -> f32
  llvm.func @llvm.pow.v2f64(vector<2xf64>, vector<2xf64>) -> vector<2xf64>
  llvm.func @llvm.pow.v2f32(vector<2xf32>, vector<2xf32>) -> vector<2xf32>
  llvm.func @llvm.pow.v4f32(vector<4xf32>, vector<4xf32>) -> vector<4xf32>
  llvm.func @pow(f64, f64) -> f64
  llvm.func @powf(f32, f32) -> f32
}
