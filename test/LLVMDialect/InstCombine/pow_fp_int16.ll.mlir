module  {
  llvm.func @pow_sitofp_const_base_fast(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_uitofp_const_base_fast(%arg0: i15) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i15 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_sitofp_double_const_base_fast(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %1 = llvm.sitofp %arg0 : i16 to f64
    %2 = llvm.call @llvm.pow.f64(%0, %1) : (f64, f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @pow_uitofp_double_const_base_fast(%arg0: i15) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i15 to f64
    %2 = llvm.call @llvm.pow.f64(%0, %1) : (f64, f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @pow_sitofp_double_const_base_2_fast(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_sitofp_double_const_base_power_of_2_fast(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(1.600000e+01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_uitofp_const_base_2_fast(%arg0: i15) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i15 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_uitofp_const_base_power_of_2_fast(%arg0: i15) -> f64 {
    %0 = llvm.mlir.constant(1.600000e+01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i15 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_sitofp_float_base_fast(%arg0: f32, %arg1: i16) -> f64 {
    %0 = llvm.sitofp %arg1 : i16 to f32
    %1 = llvm.call @llvm.pow.f32(%arg0, %0) : (f32, f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }
  llvm.func @pow_uitofp_float_base_fast(%arg0: f32, %arg1: i15) -> f64 {
    %0 = llvm.uitofp %arg1 : i15 to f32
    %1 = llvm.call @llvm.pow.f32(%arg0, %0) : (f32, f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }
  llvm.func @pow_sitofp_double_base_fast(%arg0: f64, %arg1: i16) -> f64 {
    %0 = llvm.sitofp %arg1 : i16 to f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_uitofp_double_base_fast(%arg0: f64, %arg1: i15) -> f64 {
    %0 = llvm.uitofp %arg1 : i15 to f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_sitofp_const_base_fast_i8(%arg0: i8) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i8 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_sitofp_const_base_fast_i16(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_uitofp_const_base_fast_i8(%arg0: i8) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i8 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_uitofp_const_base_afn_i16(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @powf_exp_const_int_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_exp_const2_int_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-4.000000e+01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_uitofp_const_base_fast_i16(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_uitofp_const_base_2_fast_i16(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_uitofp_const_base_power_of_2_fast_i16(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(1.600000e+01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_uitofp_float_base_fast_i16(%arg0: f32, %arg1: i16) -> f64 {
    %0 = llvm.uitofp %arg1 : i16 to f32
    %1 = llvm.call @llvm.pow.f32(%arg0, %0) : (f32, f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }
  llvm.func @pow_uitofp_double_base_fast_i16(%arg0: f64, %arg1: i16) -> f64 {
    %0 = llvm.uitofp %arg1 : i16 to f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_sitofp_const_base_no_fast(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_uitofp_const_base_no_fast(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_sitofp_const_base_2_no_fast(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_sitofp_const_base_power_of_2_no_fast(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(1.600000e+01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_uitofp_const_base_2_no_fast(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_uitofp_const_base_power_of_2_no_fast(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(1.600000e+01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i16 to f32
    %2 = llvm.call @llvm.pow.f32(%0, %1) : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @pow_sitofp_float_base_no_fast(%arg0: f32, %arg1: i16) -> f64 {
    %0 = llvm.sitofp %arg1 : i16 to f32
    %1 = llvm.call @llvm.pow.f32(%arg0, %0) : (f32, f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }
  llvm.func @pow_uitofp_float_base_no_fast(%arg0: f32, %arg1: i16) -> f64 {
    %0 = llvm.uitofp %arg1 : i16 to f32
    %1 = llvm.call @llvm.pow.f32(%arg0, %0) : (f32, f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }
  llvm.func @pow_sitofp_double_base_no_fast(%arg0: f64, %arg1: i16) -> f64 {
    %0 = llvm.sitofp %arg1 : i16 to f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_uitofp_double_base_no_fast(%arg0: f64, %arg1: i16) -> f64 {
    %0 = llvm.uitofp %arg1 : i16 to f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_exp_const_int_no_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_exp_const_not_int_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3.750000e+01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_exp_const_not_int_no_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3.750000e+01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_exp_const2_int_no_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-4.000000e+01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @llvm.pow.f32(f32, f32) -> f32
  llvm.func @llvm.pow.f64(f64, f64) -> f64
}
