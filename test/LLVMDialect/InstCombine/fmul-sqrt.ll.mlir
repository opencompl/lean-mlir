"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.sqrt.f64", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.sqrt.v2f32", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%arg1) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_a_sqrt_b", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%arg1) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_a_sqrt_b_multiple_uses", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%arg1) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_a_sqrt_b_reassoc_nnan", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%arg1) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_a_sqrt_b_reassoc", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.call"(%arg1) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.call"(%arg2) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %3 = "llvm.call"(%arg3) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %4 = "llvm.fmul"(%0, %1) : (f64, f64) -> f64
    %5 = "llvm.fmul"(%4, %2) : (f64, f64) -> f64
    %6 = "llvm.fmul"(%5, %3) : (f64, f64) -> f64
    "llvm.return"(%6) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc", type = !llvm.func<f64 (f64, f64, f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fdiv"(%0, %1) : (f64, f64) -> f64
    %3 = "llvm.fmul"(%2, %2) : (f64, f64) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "rsqrt_squared", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: !llvm.ptr<f64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fdiv"(%0, %1) : (f64, f64) -> f64
    %3 = "llvm.fmul"(%2, %arg0) : (f64, f64) -> f64
    "llvm.store"(%2, %arg1) : (f64, !llvm.ptr<f64>) -> ()
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "rsqrt_x_reassociate_extra_use", type = !llvm.func<f64 (f64, ptr<f64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: !llvm.ptr<vector<2xf32>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1.000000e+00> : vector<2xf32>} : () -> vector<2xf32>
    %1 = "llvm.fadd"(%arg0, %arg1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %2 = "llvm.call"(%1) {callee = @llvm.sqrt.v2f32, fastmathFlags = #llvm.fastmath<>} : (vector<2xf32>) -> vector<2xf32>
    %3 = "llvm.fdiv"(%0, %2) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %4 = "llvm.fmul"(%1, %3) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.store"(%3, %arg2) : (vector<2xf32>, !llvm.ptr<vector<2xf32>>) -> ()
    "llvm.return"(%4) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "x_add_y_rsqrt_reassociate_extra_use", type = !llvm.func<vector<2xf32> (vector<2xf32>, vector<2xf32>, ptr<vector<2xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fdiv"(%arg1, %0) : (f64, f64) -> f64
    %2 = "llvm.fmul"(%1, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_divisor_squared", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.sqrt.v2f32, fastmathFlags = #llvm.fastmath<>} : (vector<2xf32>) -> vector<2xf32>
    %1 = "llvm.fdiv"(%0, %arg1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %2 = "llvm.fmul"(%1, %1) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "llvm.return"(%2) : (vector<2xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_dividend_squared", type = !llvm.func<vector<2xf32> (vector<2xf32>, vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fdiv"(%arg1, %0) : (f64, f64) -> f64
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    %2 = "llvm.fmul"(%1, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_divisor_squared_extra_use", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.call"(%0) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    %1 = "llvm.fdiv"(%0, %arg1) : (f64, f64) -> f64
    %2 = "llvm.fmul"(%1, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_dividend_squared_extra_use", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64, %arg1: f64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %1 = "llvm.fdiv"(%arg1, %0) : (f64, f64) -> f64
    %2 = "llvm.fmul"(%1, %1) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_divisor_not_enough_FMF", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%arg0) {callee = @llvm.sqrt.f64, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fdiv"(%0, %1) : (f64, f64) -> f64
    "llvm.call"(%2) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (f64) -> ()
    %3 = "llvm.fmul"(%2, %2) : (f64, f64) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "rsqrt_squared_extra_use", type = !llvm.func<f64 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
