"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.call"(%0) {callee = @log, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "log_pow", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    %1 = "llvm.call"(%0) {callee = @llvm.log10.f32, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "log10f_powf", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf64>, %arg1: vector<2xf64>):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @llvm.pow.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    %1 = "llvm.call"(%0) {callee = @llvm.log2.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "log2v_powv", type = !llvm.func<vector<2xf64> (vector<2xf64>, vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %1 = "llvm.call"(%0) {callee = @log, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "log_pow_not_fast", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<func<f32 ()>>, %arg1: f32):  // no predecessors
    %0 = "llvm.call"(%arg0) : (!llvm.ptr<func<f32 ()>>) -> f32
    %1 = "llvm.call"(%0) {callee = @logf, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "function_pointer", type = !llvm.func<f32 (ptr<func<f32 ()>>, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%0) {callee = @log10, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "log10_exp", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.exp2.v2f32, fastmathFlags = #llvm.fastmath<>} : (vector<2xf32>) -> vector<2xf32>
    %1 = "llvm.call"(%0) {callee = @llvm.log.v2f32, fastmathFlags = #llvm.fastmath<>} : (vector<2xf32>) -> vector<2xf32>
    "llvm.return"(%1) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "logv_exp2v", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp10f, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    %1 = "llvm.call"(%0) {callee = @log2f, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "log2f_exp10f", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @exp2, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%0) {callee = @log, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "log_exp2_not_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: i32, %arg2: !llvm.ptr<func<f64 (i32)>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -0.000000e+00 : f64} : () -> f64
    %1 = "llvm.fsub"(%0, %arg0) : (f64, f64) -> f64
    %2 = "llvm.call"(%arg2, %arg1) : (!llvm.ptr<func<f64 (i32)>>, i32) -> f64
    %3 = "llvm.call"(%2) {callee = @llvm.log.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %4 = "llvm.fmul"(%3, %1) : (f64, f64) -> f64
    "llvm.return"(%4) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pr43617", type = !llvm.func<f64 (f64, i32, ptr<func<f64 (i32)>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "log", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "logf", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.log.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.log.v2f32", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "log2f", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.log2.v2f64", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "log10", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.log10.f32", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp2", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "exp10f", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.exp2.v2f32", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "pow", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "powf", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.v2f64", type = !llvm.func<vector<2xf64> (vector<2xf64>, vector<2xf64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
