"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @expf, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_expf", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @expf, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %1 = "llvm.call"(%0, %arg1) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_expf_libcall", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_exp", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%0, %arg1) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_exp_not_intrinsic", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f128, %arg1: f128):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @expl, fastmathFlags = #llvm.fastmath<>} : (f128) -> f128
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f128, fastmathFlags = #llvm.fastmath<>} : (f128, f128) -> f128
    "llvm.return"(%1) : (f128) -> ()
  }) {linkage = 10 : i64, sym_name = "powl_expl", type = !llvm.func<f128 (f128, f128)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f128, %arg1: f128):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @expl, fastmathFlags = #llvm.fastmath<>} : (f128) -> f128
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f128, fastmathFlags = #llvm.fastmath<>} : (f128, f128) -> f128
    "llvm.return"(%1) : (f128) -> ()
  }) {linkage = 10 : i64, sym_name = "powl_expl_not_fast", type = !llvm.func<f128 (f128, f128)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp2f, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_exp2f", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp2f, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %1 = "llvm.call"(%0, %arg1) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_exp2f_not_intrinsic", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_exp2", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%0, %arg1) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_exp2_libcall", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f128, %arg1: f128):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp2l, fastmathFlags = #llvm.fastmath<>} : (f128) -> f128
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f128, fastmathFlags = #llvm.fastmath<>} : (f128, f128) -> f128
    "llvm.return"(%1) : (f128) -> ()
  }) {linkage = 10 : i64, sym_name = "powl_exp2l", type = !llvm.func<f128 (f128, f128)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f128, %arg1: f128):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp2l, fastmathFlags = #llvm.fastmath<>} : (f128) -> f128
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f128, fastmathFlags = #llvm.fastmath<>} : (f128, f128) -> f128
    "llvm.return"(%1) : (f128) -> ()
  }) {linkage = 10 : i64, sym_name = "powl_exp2l_not_fast", type = !llvm.func<f128 (f128, f128)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp10f, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_exp10f", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp10, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_exp10", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f128, %arg1: f128):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp10l, fastmathFlags = #llvm.fastmath<>} : (f128) -> f128
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f128, fastmathFlags = #llvm.fastmath<>} : (f128, f128) -> f128
    "llvm.return"(%1) : (f128) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_exp10l", type = !llvm.func<f128 (f128, f128)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: !llvm.ptr<f32>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @expf, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %1 = "llvm.call"(%0, %arg1) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.store"(%0, %arg2) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "reuse_fast", type = !llvm.func<f32 (f32, f32, ptr<f32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f128, %arg1: f128, %arg2: !llvm.ptr<f128>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @expl, fastmathFlags = #llvm.fastmath<>} : (f128) -> f128
    %1 = "llvm.call"(%0, %arg1) {callee = @powl, fastmathFlags = #llvm.fastmath<>} : (f128, f128) -> f128
    "llvm.store"(%0, %arg2) : (f128, !llvm.ptr<f128>) -> ()
    "llvm.return"(%1) : (f128) -> ()
  }) {linkage = 10 : i64, sym_name = "reuse_libcall", type = !llvm.func<f128 (f128, f128, ptr<f128>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<func<f64 ()>>, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) : (!llvm.ptr<func<f64 ()>>) -> f64
    %1 = "llvm.call"(%0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "function_pointer", type = !llvm.func<f64 (ptr<func<f64 ()>>, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use_d", type = !llvm.func<void (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use_f", type = !llvm.func<void (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.69999999999999996 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ok_base", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.69999999999999996 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ok_base_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.770000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ok_base2", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.010000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ok_base3", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ok_ten_base", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2.1219957904712067E-314 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ok_denorm_base", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.699999988 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_ok_base", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.770000e+01 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_ok_base2", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.010000e+01 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_ok_base3", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+01 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_ok_ten_base", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2.295890e-41 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_ok_denorm_base", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_zero_base", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -0.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_zero_base2", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0x7FF0000000000000 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_inf_base", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0x7FF8000000000000 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_nan_base", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_negative_base", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.call"(%1) {callee = @use_d, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_multiuse", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.69999999999999996 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ok_base_no_afn", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.69999999999999996 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ok_base_no_nnan", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.69999999999999996 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ok_base_no_ninf", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.000000e+00 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_zero_base", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -0.000000e+00 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_zero_base2", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0x7F800000 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_inf_base", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0x7FC00000 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_nan_base", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4.000000e+00 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_negative_base", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e+00 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.call"(%1) {callee = @use_f, fastmathFlags = #llvm.fastmath<>} : (f32) -> ()
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_multiuse", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.699999988 : f32} : () -> f32
    %1 = "llvm.call"(%0, %arg0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_ok_base_no_afn", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f128):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4.17755552565261002676701084286649753E+1233 : f32} : () -> f128
    %1 = "llvm.call"(%0, %arg0) {callee = @powl, fastmathFlags = #llvm.fastmath<>} : (f128, f128) -> f128
    "llvm.return"(%1) : (f128) -> ()
  }) {linkage = 10 : i64, sym_name = "powl_long_dbl_no_fold", type = !llvm.func<f128 (f128)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "expf", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "expl", type = !llvm.func<f128 (f128)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp2f", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp2", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp2l", type = !llvm.func<f128 (f128)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp10f", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp10", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp10l", type = !llvm.func<f128 (f128)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "powf", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "pow", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "powl", type = !llvm.func<f128 (f128, f128)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.f32", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.f64", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.f128", type = !llvm.func<f128 (f128, f128)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
