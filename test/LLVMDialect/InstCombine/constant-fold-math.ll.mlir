"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fma.f32", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fmuladd.f32", type = !llvm.func<f32 (f32, f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fma.v4f32", type = !llvm.func<vector<4xf32> (vector<4xf32>, vector<4xf32>, vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fma.f64", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fmuladd.f64", type = !llvm.func<f64 (f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.sqrt.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4.000000e+00 : f32} : () -> f32
    %1 = "llvm.mlir.constant"() {value = 2.000000e+00 : f32} : () -> f32
    %2 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %3 = "llvm.call"(%2, %1, %0) {callee = @llvm.fma.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32, f32) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_fma_f32", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = dense<1.000000e+01> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.mlir.constant"() {value = dense<2.000000e+00> : vector<4xf32>} : () -> vector<4xf32>
    %2 = "llvm.mlir.constant"() {value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>} : () -> vector<4xf32>
    %3 = "llvm.call"(%2, %1, %0) {callee = @llvm.fma.v4f32, fastmathFlags = #llvm.fastmath<>} : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%3) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_fma_v4f32", type = !llvm.func<vector<4xf32> ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4.000000e+00 : f32} : () -> f32
    %1 = "llvm.mlir.constant"() {value = 2.000000e+00 : f32} : () -> f32
    %2 = "llvm.mlir.constant"() {value = 1.000000e+00 : f32} : () -> f32
    %3 = "llvm.call"(%2, %1, %0) {callee = @llvm.fmuladd.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32, f32) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_fmuladd_f32", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4.000000e+00 : f64} : () -> f64
    %1 = "llvm.mlir.constant"() {value = 2.000000e+00 : f64} : () -> f64
    %2 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %3 = "llvm.call"(%2, %1, %0) {callee = @llvm.fma.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64, f64) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_fma_f64", type = !llvm.func<f64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4.000000e+00 : f64} : () -> f64
    %1 = "llvm.mlir.constant"() {value = 2.000000e+00 : f64} : () -> f64
    %2 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %3 = "llvm.call"(%2, %1, %0) {callee = @llvm.fmuladd.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64, f64) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_fmuladd_f64", type = !llvm.func<f64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -2.50991821E+9 : f32} : () -> f32
    %1 = "llvm.mlir.constant"() {value = 4.03345148E+18 : f32} : () -> f32
    %2 = "llvm.frem"(%1, %0) : (f32, f32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_frem_f32", type = !llvm.func<f32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.mlir.constant"() {value = 9.2233720368547758E+18 : f64} : () -> f64
    %2 = "llvm.frem"(%1, %0) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "constant_fold_frem_f64", type = !llvm.func<f64 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
