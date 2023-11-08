"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ceil.f32", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ceil.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ceil.v4f32", type = !llvm.func<vector<4xf32> (vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %1 = "llvm.call"(%0) {callee = @llvm.ceil.f32, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_ceil_f32_01", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1.250000e+00 : f32} : () -> f32
    %1 = "llvm.call"(%0) {callee = @llvm.ceil.f32, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_ceil_f32_02", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -1.250000e+00 : f32} : () -> f32
    %1 = "llvm.call"(%0) {callee = @llvm.ceil.f32, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_ceil_f32_03", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 1.250000e+00, -1.250000e+00, -1.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.call"(%0) {callee = @llvm.ceil.v4f32, fastmathFlags = #llvm.fastmath<>} : (vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%1) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_ceil_v4f32_01", type = !llvm.func<vector<4xf32> ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.ceil.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_ceil_f64_01", type = !llvm.func<f64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1.300000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.ceil.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_ceil_f64_02", type = !llvm.func<f64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -1.750000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @llvm.ceil.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_ceil_f64_03", type = !llvm.func<f64 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
