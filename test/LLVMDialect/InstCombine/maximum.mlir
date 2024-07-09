module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @constant_fold_maximum_f32() -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @constant_fold_maximum_f32_inv() -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @constant_fold_maximum_f32_nan0() -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @constant_fold_maximum_f32_nan1() -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @constant_fold_maximum_f32_nan_nan() -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.intr.maximum(%0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @constant_fold_maximum_f32_p0_p0() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @constant_fold_maximum_f32_p0_n0() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @constant_fold_maximum_f32_n0_p0() -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @constant_fold_maximum_f32_n0_n0() -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @constant_fold_maximum_v4f32() -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 8.000000e+00, 3.000000e+00, 9.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[2.000000e+00, 2.000000e+00, 1.000000e+01, 5.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.intr.maximum(%0, %1)  : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @constant_fold_maximum_f64() -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.intr.maximum(%0, %1)  : (f64, f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @constant_fold_maximum_f64_nan0() -> f64 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.intr.maximum(%0, %1)  : (f64, f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @constant_fold_maximum_f64_nan1() -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %2 = llvm.intr.maximum(%0, %1)  : (f64, f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @constant_fold_maximum_f64_nan_nan() -> f64 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = llvm.intr.maximum(%0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @canonicalize_constant_maximum_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%0, %arg0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @maximum_f32_nan_val(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.intr.maximum(%0, %arg0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @maximum_f32_val_nan(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @maximum_f32_1_maximum_val_p0(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    %3 = llvm.intr.maximum(%2, %1)  : (f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @maximum_f32_1_maximum_p0_val_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %arg0)  : (f32, f32) -> f32
    %3 = llvm.intr.maximum(%2, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @maximum_f32_1_maximum_p0_val_fmf1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, arcp>} : (f32, f32) -> f32
    %3 = llvm.intr.maximum(%2, %1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, arcp>} : (f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @maximum_f32_1_maximum_p0_val_fmf2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, arcp>} : (f32, f32) -> f32
    %3 = llvm.intr.maximum(%2, %1)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @maximum_f32_1_maximum_p0_val_fmf3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f32, f32) -> f32
    %3 = llvm.intr.maximum(%2, %1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, arcp>} : (f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @maximum_f32_p0_maximum_val_n0(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    %3 = llvm.intr.maximum(%2, %1)  : (f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @maximum_f32_1_maximum_p0_val(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %arg0)  : (f32, f32) -> f32
    %3 = llvm.intr.maximum(%2, %1)  : (f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @maximum_f32_1_maximum_val_p0_val_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.intr.maximum(%arg0, %1)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %4 = llvm.intr.maximum(%3, %2)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @maximum4(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg2, %arg3)  : (f32, f32) -> f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @neg_neg(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fsub %0, %arg1  : vector<2xf32>
    %3 = llvm.intr.maximum(%1, %2)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @unary_neg_neg(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.intr.maximum(%0, %1)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @neg_neg_vec_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<arcp>} : f32
    %2 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<afn>} : f32
    %3 = llvm.intr.maximum(%1, %2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @unary_neg_neg_vec_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<arcp>} : f32
    %1 = llvm.fneg %arg1  {fastmathFlags = #llvm.fastmath<afn>} : f32
    %2 = llvm.intr.maximum(%0, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @use(f32)
  llvm.func @neg_neg_extra_use_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.maximum(%1, %2)  : (f32, f32) -> f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %3 : f32
  }
  llvm.func @unary_neg_neg_extra_use_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @neg_neg_extra_use_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.maximum(%1, %2)  : (f32, f32) -> f32
    llvm.call @use(%2) : (f32) -> ()
    llvm.return %3 : f32
  }
  llvm.func @unary_neg_neg_extra_use_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @neg_neg_extra_use_x_and_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.maximum(%1, %2)  : (f32, f32) -> f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.call @use(%2) : (f32) -> ()
    llvm.return %3 : f32
  }
  llvm.func @unary_neg_neg_extra_use_x_and_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @reduce_precision(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.maximum(%0, %1)  : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @reduce_precision_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.maximum(%0, %1)  {fastmathFlags = #llvm.fastmath<nnan>} : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @negated_op(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @negated_op_fmf_commute_vec(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fneg %arg0  : vector<2xf64>
    %1 = llvm.intr.maximum(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @negated_op_extra_use(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.intr.maximum(%0, %arg0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @negated_op_extra_use_comm(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
}
