module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @cos(f64) -> f64
  llvm.func @cosf(f32) -> f32
  llvm.func @sin(f64) -> f64
  llvm.func @sinf(f32) -> f32
  llvm.func @tan(f64) -> f64
  llvm.func @tanl(f128) -> f128
  llvm.func @fabs(f64) -> f64
  llvm.func @fabsf(f32) -> f32
  llvm.func @cos_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @cos(%1) : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @cos_negated_arg_tail(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @cos(%1) : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @cos_negated_arg_musttail(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @cos(%1) : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @cos_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @cosf_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.call @cosf(%1) : (f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @cosf_unary_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.call @cosf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @cosf_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.call @cosf(%1) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @cosf_unary_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.call @cosf(%0) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @cos_unary_fabs_arg(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @cosf_unary_fabs_arg(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.call @cosf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @cosf_unary_fabs_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.call @cosf(%0) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @cos_copysign_arg(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @cosf_unary_copysign_arg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.copysign(%arg0, %0)  : (f32, f32) -> f32
    %2 = llvm.call @cosf(%1) : (f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @cosf_copysign_arg_FMF(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.call @cosf(%0) {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @sin_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @sin(%1) : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @sin_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sin_unary_negated_arg_musttail(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sinf_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.call @sinf(%1) : (f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @sinf_unary_negated_arg(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.call @sinf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @sinf_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %2 = llvm.call @sinf(%1) {fastmathFlags = #llvm.fastmath<nnan, afn>} : (f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @sinf_unary_negated_arg_FMF(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %1 = llvm.call @sinf(%0) {fastmathFlags = #llvm.fastmath<nnan, afn>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @use(f64)
  llvm.func @sin_negated_arg_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @sin(%1) : (f64) -> f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }
  llvm.func @sin_unary_negated_arg_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }
  llvm.func @neg_sin_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @sin(%1) : (f64) -> f64
    %3 = llvm.fsub %0, %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @unary_neg_sin_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    %2 = llvm.fneg %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @neg_sin_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @sin(%1) : (f64) -> f64
    %3 = llvm.fneg %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @unary_neg_sin_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fneg %arg0  : f64
    %2 = llvm.call @sin(%1) : (f64) -> f64
    %3 = llvm.fsub %0, %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @tan_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @tan(%1) : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @tan_negated_arg_tail(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @tan(%1) : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @tan_negated_arg_musttail(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @tan(%1) : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @tan_unary_negated_arg(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @tan(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @tanl_negated_arg(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f128) : f128
    %1 = llvm.fsub %0, %arg0  : f128
    %2 = llvm.call @tanl(%1) : (f128) -> f128
    llvm.return %2 : f128
  }
  llvm.func @tanl_unary_negated_arg(%arg0: f128) -> f128 {
    %0 = llvm.fneg %arg0  : f128
    %1 = llvm.call @tanl(%0) : (f128) -> f128
    llvm.return %1 : f128
  }
  llvm.func @negated_and_shrinkable_libcall(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fsub %0, %1  : f64
    %3 = llvm.call @cos(%2) : (f64) -> f64
    %4 = llvm.fptrunc %3 : f64 to f32
    llvm.return %4 : f32
  }
  llvm.func @unary_negated_and_shrinkable_libcall(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fneg %0  : f64
    %2 = llvm.call @cos(%1) : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @negated_and_shrinkable_intrinsic(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fsub %0, %1  : f64
    %3 = llvm.intr.cos(%2)  : (f64) -> f64
    %4 = llvm.fptrunc %3 : f64 to f32
    llvm.return %4 : f32
  }
  llvm.func @unary_negated_and_shrinkable_intrinsic(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fneg %0  : f64
    %2 = llvm.intr.cos(%1)  : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
}
