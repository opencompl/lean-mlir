module  {
  llvm.func @floor(f64) -> f64
  llvm.func @ceil(f64) -> f64
  llvm.func @round(f64) -> f64
  llvm.func @roundeven(f64) -> f64
  llvm.func @nearbyint(f64) -> f64
  llvm.func @trunc(f64) -> f64
  llvm.func @fabs(f64) -> f64
  llvm.func @llvm.ceil.f64(f64) -> f64
  llvm.func @llvm.ceil.v2f64(vector<2xf64>) -> vector<2xf64>
  llvm.func @llvm.fabs.f64(f64) -> f64
  llvm.func @llvm.fabs.v2f64(vector<2xf64>) -> vector<2xf64>
  llvm.func @llvm.floor.f64(f64) -> f64
  llvm.func @llvm.floor.v2f64(vector<2xf64>) -> vector<2xf64>
  llvm.func @llvm.nearbyint.f64(f64) -> f64
  llvm.func @llvm.nearbyint.v2f64(vector<2xf64>) -> vector<2xf64>
  llvm.func @llvm.rint.f32(f32) -> f32
  llvm.func @llvm.rint.v2f32(vector<2xf32>) -> vector<2xf32>
  llvm.func @llvm.round.f64(f64) -> f64
  llvm.func @llvm.round.v2f64(vector<2xf64>) -> vector<2xf64>
  llvm.func @llvm.roundeven.f64(f64) -> f64
  llvm.func @llvm.roundeven.v2f64(vector<2xf64>) -> vector<2xf64>
  llvm.func @llvm.trunc.f64(f64) -> f64
  llvm.func @llvm.trunc.v2f64(vector<2xf64>) -> vector<2xf64>
  llvm.func @test_shrink_libcall_floor(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @floor(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_libcall_ceil(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @ceil(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_libcall_round(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @round(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_libcall_roundeven(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @roundeven(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_libcall_nearbyint(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @nearbyint(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_libcall_trunc(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @trunc(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_libcall_fabs(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @fabs(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_libcall_fabs_fast(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @fabs(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_intrin_ceil(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @llvm.ceil.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_intrin_fabs(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @llvm.fabs.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_intrin_floor(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @llvm.floor.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_intrin_nearbyint(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @llvm.nearbyint.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_intrin_rint(%arg0: f16) -> f16 {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.call @llvm.rint.f32(%0) : (f32) -> f32
    %2 = llvm.fptrunc %1 : f32 to f16
    llvm.return %2 : f16
  }
  llvm.func @test_shrink_intrin_round(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @llvm.round.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_intrin_roundeven(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @llvm.roundeven.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_intrin_trunc(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @llvm.trunc.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @use_v2f64(vector<2xf64>)
  llvm.func @use_v2f32(vector<2xf32>)
  llvm.func @test_shrink_intrin_ceil_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.call @llvm.ceil.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @test_shrink_intrin_fabs_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.call @llvm.fabs.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @test_shrink_intrin_floor_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.call @llvm.floor.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @test_shrink_intrin_nearbyint_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.call @llvm.nearbyint.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @test_shrink_intrin_rint_multi_use(%arg0: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf32>
    %1 = llvm.call @llvm.rint.v2f32(%0) : (vector<2xf32>) -> vector<2xf32>
    %2 = llvm.fptrunc %1 : vector<2xf32> to vector<2xf16>
    llvm.call @use_v2f32(%1) : (vector<2xf32>) -> ()
    llvm.return %2 : vector<2xf16>
  }
  llvm.func @test_shrink_intrin_round_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.call @llvm.round.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @test_shrink_intrin_roundeven_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.call @llvm.roundeven.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @test_shrink_intrin_trunc_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.call @llvm.trunc.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @test_shrink_intrin_fabs_fast(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @llvm.fabs.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_no_shrink_intrin_floor(%arg0: f64) -> f32 {
    %0 = llvm.call @llvm.floor.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }
  llvm.func @test_no_shrink_intrin_ceil(%arg0: f64) -> f32 {
    %0 = llvm.call @llvm.ceil.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }
  llvm.func @test_no_shrink_intrin_round(%arg0: f64) -> f32 {
    %0 = llvm.call @llvm.round.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }
  llvm.func @test_no_shrink_intrin_roundeven(%arg0: f64) -> f32 {
    %0 = llvm.call @llvm.roundeven.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }
  llvm.func @test_no_shrink_intrin_nearbyint(%arg0: f64) -> f32 {
    %0 = llvm.call @llvm.nearbyint.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }
  llvm.func @test_no_shrink_intrin_trunc(%arg0: f64) -> f32 {
    %0 = llvm.call @llvm.trunc.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }
  llvm.func @test_shrink_intrin_fabs_double_src(%arg0: f64) -> f32 {
    %0 = llvm.call @llvm.fabs.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }
  llvm.func @test_shrink_intrin_fabs_fast_double_src(%arg0: f64) -> f32 {
    %0 = llvm.call @llvm.fabs.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }
  llvm.func @test_shrink_float_convertible_constant_intrin_floor() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.call @llvm.floor.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_float_convertible_constant_intrin_ceil() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.call @llvm.ceil.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_float_convertible_constant_intrin_round() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.call @llvm.round.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_float_convertible_constant_intrin_roundeven() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.call @llvm.roundeven.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_float_convertible_constant_intrin_nearbyint() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.call @llvm.nearbyint.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_float_convertible_constant_intrin_trunc() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.call @llvm.trunc.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_float_convertible_constant_intrin_fabs() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.call @llvm.fabs.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_float_convertible_constant_intrin_fabs_fast() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.call @llvm.fabs.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_no_shrink_mismatched_type_intrin_floor(%arg0: f64) -> f16 {
    %0 = llvm.call @llvm.floor.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }
  llvm.func @test_no_shrink_mismatched_type_intrin_ceil(%arg0: f64) -> f16 {
    %0 = llvm.call @llvm.ceil.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }
  llvm.func @test_no_shrink_mismatched_type_intrin_round(%arg0: f64) -> f16 {
    %0 = llvm.call @llvm.round.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }
  llvm.func @test_no_shrink_mismatched_type_intrin_roundeven(%arg0: f64) -> f16 {
    %0 = llvm.call @llvm.roundeven.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }
  llvm.func @test_no_shrink_mismatched_type_intrin_nearbyint(%arg0: f64) -> f16 {
    %0 = llvm.call @llvm.nearbyint.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }
  llvm.func @test_no_shrink_mismatched_type_intrin_trunc(%arg0: f64) -> f16 {
    %0 = llvm.call @llvm.trunc.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }
  llvm.func @test_shrink_mismatched_type_intrin_fabs_double_src(%arg0: f64) -> f16 {
    %0 = llvm.call @llvm.fabs.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }
  llvm.func @test_mismatched_type_intrin_fabs_fast_double_src(%arg0: f64) -> f16 {
    %0 = llvm.call @llvm.fabs.f64(%arg0) : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }
  llvm.func @test_shrink_intrin_floor_fp16_vec(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.call @llvm.floor.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @test_shrink_intrin_ceil_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.call @llvm.ceil.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_intrin_round_fp16_vec(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.call @llvm.round.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @test_shrink_intrin_roundeven_fp16_vec(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.call @llvm.roundeven.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @test_shrink_intrin_nearbyint_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.call @llvm.nearbyint.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_intrin_trunc_fp16_src(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.call @llvm.trunc.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @test_shrink_intrin_fabs_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.call @llvm.fabs.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_shrink_intrin_fabs_fast_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.call @llvm.fabs.f64(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test_no_shrink_intrin_floor_multi_use_fpext(%arg0: f16) -> f32 {
    %0 = llvm.mlir.undef : !llvm.ptr<f64>
    %1 = llvm.fpext %arg0 : f16 to f64
    llvm.store %1, %0 : !llvm.ptr<f64>
    %2 = llvm.call @llvm.floor.f64(%1) : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test_no_shrink_intrin_fabs_multi_use_fpext(%arg0: f16) -> f32 {
    %0 = llvm.mlir.undef : !llvm.ptr<f64>
    %1 = llvm.fpext %arg0 : f16 to f64
    llvm.store %1, %0 : !llvm.ptr<f64>
    %2 = llvm.call @llvm.fabs.f64(%1) : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
}
