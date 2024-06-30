"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.f64", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.f32", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.v2f64", type = !llvm.func<vector<2xf64> (vector<2xf64>, vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.v2f32", type = !llvm.func<vector<2xf32> (vector<2xf32>, vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.v4f32", type = !llvm.func<vector<4xf32> (vector<4xf32>, vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "pow", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_3", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4.000000e+00 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_4f", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_4", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1.500000e+01> : vector<2xf32>} : () -> vector<2xf32>
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.v2f32, fastmathFlags = #llvm.fastmath<>} : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"(%1) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_15", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-7.000000e+00> : vector<2xf64>} : () -> vector<2xf64>
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_neg_7", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1.900000e+01 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_neg_19", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.123000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_11_23", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3.200000e+01 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_32", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3.300000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_33", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.650000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_16_5", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1.650000e+01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_neg_16_5", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_0_5_libcall", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_neg_0_5_libcall", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8.500000e+00 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_neg_8_5", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<7.500000e+00> : vector<2xf64>} : () -> vector<2xf64>
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_7_5", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<3.500000e+00> : vector<4xf32>} : () -> vector<4xf32>
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.v4f32, fastmathFlags = #llvm.fastmath<>} : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%1) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_3_5", type = !llvm.func<vector<4xf32> (vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.fpext"(%arg0) : (f32) -> f64
    %2 = "llvm.call"(%1, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "shrink_pow_libcall_half", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -0.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "PR43233", type = !llvm.func<f64 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
