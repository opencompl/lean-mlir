"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7.000000e+00 : f32} : () -> f32
    %1 = "llvm.sitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_const_base_fast", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i15):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7.000000e+00 : f32} : () -> f32
    %1 = "llvm.uitofp"(%arg0) : (i15) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_const_base_fast", type = !llvm.func<f64 (i15)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7.000000e+00 : f64} : () -> f64
    %1 = "llvm.sitofp"(%arg0) : (i16) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_double_const_base_fast", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i15):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7.000000e+00 : f64} : () -> f64
    %1 = "llvm.uitofp"(%arg0) : (i15) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_double_const_base_fast", type = !llvm.func<f64 (i15)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2.000000e+00 : f32} : () -> f32
    %1 = "llvm.sitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_double_const_base_2_fast", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.600000e+01 : f32} : () -> f32
    %1 = "llvm.sitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_double_const_base_power_of_2_fast", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i15):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2.000000e+00 : f32} : () -> f32
    %1 = "llvm.uitofp"(%arg0) : (i15) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_const_base_2_fast", type = !llvm.func<f64 (i15)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i15):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.600000e+01 : f32} : () -> f32
    %1 = "llvm.uitofp"(%arg0) : (i15) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_const_base_power_of_2_fast", type = !llvm.func<f64 (i15)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: i16):  // no predecessors
    %0 = "llvm.sitofp"(%arg1) : (i16) -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %2 = "llvm.fpext"(%1) : (f32) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_float_base_fast", type = !llvm.func<f64 (f32, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: i15):  // no predecessors
    %0 = "llvm.uitofp"(%arg1) : (i15) -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %2 = "llvm.fpext"(%1) : (f32) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_float_base_fast", type = !llvm.func<f64 (f32, i15)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: i16):  // no predecessors
    %0 = "llvm.sitofp"(%arg1) : (i16) -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_double_base_fast", type = !llvm.func<f64 (f64, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: i15):  // no predecessors
    %0 = "llvm.uitofp"(%arg1) : (i15) -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_double_base_fast", type = !llvm.func<f64 (f64, i15)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7.000000e+00 : f32} : () -> f32
    %1 = "llvm.sitofp"(%arg0) : (i8) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_const_base_fast_i8", type = !llvm.func<f64 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7.000000e+00 : f32} : () -> f32
    %1 = "llvm.sitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_const_base_fast_i16", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7.000000e+00 : f32} : () -> f32
    %1 = "llvm.uitofp"(%arg0) : (i8) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_const_base_fast_i8", type = !llvm.func<f64 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7.000000e+00 : f32} : () -> f32
    %1 = "llvm.uitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_const_base_afn_i16", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4.000000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_exp_const_int_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4.000000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_exp_const2_int_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7.000000e+00 : f32} : () -> f32
    %1 = "llvm.uitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_const_base_fast_i16", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2.000000e+00 : f32} : () -> f32
    %1 = "llvm.uitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_const_base_2_fast_i16", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.600000e+01 : f32} : () -> f32
    %1 = "llvm.uitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_const_base_power_of_2_fast_i16", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: i16):  // no predecessors
    %0 = "llvm.uitofp"(%arg1) : (i16) -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %2 = "llvm.fpext"(%1) : (f32) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_float_base_fast_i16", type = !llvm.func<f64 (f32, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: i16):  // no predecessors
    %0 = "llvm.uitofp"(%arg1) : (i16) -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_double_base_fast_i16", type = !llvm.func<f64 (f64, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7.000000e+00 : f32} : () -> f32
    %1 = "llvm.sitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_const_base_no_fast", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7.000000e+00 : f32} : () -> f32
    %1 = "llvm.uitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_const_base_no_fast", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2.000000e+00 : f32} : () -> f32
    %1 = "llvm.sitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_const_base_2_no_fast", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.600000e+01 : f32} : () -> f32
    %1 = "llvm.sitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_const_base_power_of_2_no_fast", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2.000000e+00 : f32} : () -> f32
    %1 = "llvm.uitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_const_base_2_no_fast", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.600000e+01 : f32} : () -> f32
    %1 = "llvm.uitofp"(%arg0) : (i16) -> f32
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %3 = "llvm.fpext"(%2) : (f32) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_const_base_power_of_2_no_fast", type = !llvm.func<f64 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: i16):  // no predecessors
    %0 = "llvm.sitofp"(%arg1) : (i16) -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %2 = "llvm.fpext"(%1) : (f32) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_float_base_no_fast", type = !llvm.func<f64 (f32, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: i16):  // no predecessors
    %0 = "llvm.uitofp"(%arg1) : (i16) -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %2 = "llvm.fpext"(%1) : (f32) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_float_base_no_fast", type = !llvm.func<f64 (f32, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: i16):  // no predecessors
    %0 = "llvm.sitofp"(%arg1) : (i16) -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_sitofp_double_base_no_fast", type = !llvm.func<f64 (f64, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: i16):  // no predecessors
    %0 = "llvm.uitofp"(%arg1) : (i16) -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_uitofp_double_base_no_fast", type = !llvm.func<f64 (f64, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4.000000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_exp_const_int_no_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3.750000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_exp_const_not_int_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3.750000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_exp_const_not_int_no_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4.000000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_exp_const2_int_no_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.f32", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.f64", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
