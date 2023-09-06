module  {
  llvm.func @powf_expf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @expf(%arg0) : (f32) -> f32
    %1 = llvm.call @llvm.pow.f32(%0, %arg1) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_expf_libcall(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @expf(%arg0) : (f32) -> f32
    %1 = llvm.call @powf(%0, %arg1) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_exp(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.pow.f64(%0, %arg1) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_exp_not_intrinsic(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) : (f64) -> f64
    %1 = llvm.call @pow(%0, %arg1) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powl_expl(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @expl(%arg0) : (f128) -> f128
    %1 = llvm.call @llvm.pow.f128(%0, %arg1) : (f128, f128) -> f128
    llvm.return %1 : f128
  }
  llvm.func @powl_expl_not_fast(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @expl(%arg0) : (f128) -> f128
    %1 = llvm.call @llvm.pow.f128(%0, %arg1) : (f128, f128) -> f128
    llvm.return %1 : f128
  }
  llvm.func @powf_exp2f(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @exp2f(%arg0) : (f32) -> f32
    %1 = llvm.call @llvm.pow.f32(%0, %arg1) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_exp2f_not_intrinsic(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @exp2f(%arg0) : (f32) -> f32
    %1 = llvm.call @powf(%0, %arg1) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_exp2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.pow.f64(%0, %arg1) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_exp2_libcall(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    %1 = llvm.call @pow(%0, %arg1) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powl_exp2l(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @exp2l(%arg0) : (f128) -> f128
    %1 = llvm.call @llvm.pow.f128(%0, %arg1) : (f128, f128) -> f128
    llvm.return %1 : f128
  }
  llvm.func @powl_exp2l_not_fast(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @exp2l(%arg0) : (f128) -> f128
    %1 = llvm.call @llvm.pow.f128(%0, %arg1) : (f128, f128) -> f128
    llvm.return %1 : f128
  }
  llvm.func @powf_exp10f(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @exp10f(%arg0) : (f32) -> f32
    %1 = llvm.call @llvm.pow.f32(%0, %arg1) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_exp10(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp10(%arg0) : (f64) -> f64
    %1 = llvm.call @llvm.pow.f64(%0, %arg1) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_exp10l(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @exp10l(%arg0) : (f128) -> f128
    %1 = llvm.call @llvm.pow.f128(%0, %arg1) : (f128, f128) -> f128
    llvm.return %1 : f128
  }
  llvm.func @reuse_fast(%arg0: f32, %arg1: f32, %arg2: !llvm.ptr<f32>) -> f32 {
    %0 = llvm.call @expf(%arg0) : (f32) -> f32
    %1 = llvm.call @powf(%0, %arg1) : (f32, f32) -> f32
    llvm.store %0, %arg2 : !llvm.ptr<f32>
    llvm.return %1 : f32
  }
  llvm.func @reuse_libcall(%arg0: f128, %arg1: f128, %arg2: !llvm.ptr<f128>) -> f128 {
    %0 = llvm.call @expl(%arg0) : (f128) -> f128
    %1 = llvm.call @powl(%0, %arg1) : (f128, f128) -> f128
    llvm.store %0, %arg2 : !llvm.ptr<f128>
    llvm.return %1 : f128
  }
  llvm.func @function_pointer(%arg0: !llvm.ptr<func<f64 ()>>, %arg1: f64) -> f64 {
    %0 = llvm.call %arg0() : () -> f64
    %1 = llvm.call @llvm.pow.f64(%0, %arg1) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @use_d(f64)
  llvm.func @use_f(f32)
  llvm.func @pow_ok_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ok_base_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ok_base2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.770000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ok_base3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.010000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ok_ten_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ok_denorm_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.1219957904712067E-314 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_ok_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.699999988 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_ok_base2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.770000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_ok_base3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.010000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_ok_ten_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_ok_denorm_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.295890e-41 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_zero_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_zero_base2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_inf_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_nan_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_negative_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-4.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_multiuse(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.call @use_d(%1) : (f64) -> ()
    llvm.return %1 : f64
  }
  llvm.func @pow_ok_base_no_afn(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ok_base_no_nnan(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_ok_base_no_ninf(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_zero_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_zero_base2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_inf_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_nan_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_negative_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_multiuse(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.call @use_f(%1) : (f32) -> ()
    llvm.return %1 : f32
  }
  llvm.func @powf_ok_base_no_afn(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.699999988 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powl_long_dbl_no_fold(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(4.17755552565261002676701084286649753E+1233 : f32) : f128
    %1 = llvm.call @powl(%0, %arg0) : (f128, f128) -> f128
    llvm.return %1 : f128
  }
  llvm.func @expf(f32) -> f32
  llvm.func @exp(f64) -> f64
  llvm.func @expl(f128) -> f128
  llvm.func @exp2f(f32) -> f32
  llvm.func @exp2(f64) -> f64
  llvm.func @exp2l(f128) -> f128
  llvm.func @exp10f(f32) -> f32
  llvm.func @exp10(f64) -> f64
  llvm.func @exp10l(f128) -> f128
  llvm.func @powf(f32, f32) -> f32
  llvm.func @pow(f64, f64) -> f64
  llvm.func @powl(f128, f128) -> f128
  llvm.func @llvm.pow.f32(f32, f32) -> f32
  llvm.func @llvm.pow.f64(f64, f64) -> f64
  llvm.func @llvm.pow.f128(f128, f128) -> f128
}
