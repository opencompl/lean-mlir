"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.f64", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.fmul"(%0, %arg0) : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ab_a", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.fmul"(%0, %arg0) : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ab_a_reassoc", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.fdiv"(%0, %arg0) : (f64, f64) -> f64
    %2 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %3 = "llvm.fmul"(%1, %2) : (f64, f64) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ab_a_reassoc_commute", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.call"(%arg2, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %2 = "llvm.fmul"(%1, %0) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ab_pow_cb", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.call"(%arg2, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %2 = "llvm.fmul"(%1, %0) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ab_pow_cb_reassoc", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.call"(%arg0, %arg2) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %2 = "llvm.fmul"(%1, %0) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ab_pow_ac", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.call"(%arg0, %arg2) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %2 = "llvm.fmul"(%1, %0) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ab_x_pow_ac_reassoc", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.fmul"(%0, %0) : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ab_reassoc", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.fmul"(%0, %0) : (f64, f64) -> f64
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ab_reassoc_extra_use", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.call"(%arg0, %arg2) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %2 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ab_x_pow_ac_reassoc_extra_use", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.call"(%arg0, %arg2) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %2 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_ab_x_pow_ac_reassoc_multiple_uses", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
