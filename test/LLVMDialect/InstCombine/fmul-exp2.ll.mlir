"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.exp2.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%arg1) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "exp2_a_exp2_b", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%arg1) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "exp2_a_exp2_b_multiple_uses", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fmul"(%0, %0) : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "exp2_a_a", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%arg1) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "exp2_a_exp2_b_multiple_uses_both", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%arg1) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "exp2_a_exp2_b_reassoc", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%arg1) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    %3 = "llvm.call"(%arg2) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %4 = "llvm.fmul"(%2, %3) : (f64, f64) -> f64
    %5 = "llvm.call"(%arg3) {callee = @llvm.exp2.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %6 = "llvm.fmul"(%4, %5) : (f64, f64) -> f64
    "llvm.return"(%6) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "exp2_a_exp2_b_exp2_c_exp2_d", type = !llvm.func<f64 (f64, f64, f64, f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
