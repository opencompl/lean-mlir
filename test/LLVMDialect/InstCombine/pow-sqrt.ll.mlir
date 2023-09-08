"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_half_no_FMF", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_half_no_FMF", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_half_approx", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<5.000000e-01> : vector<2xf64>} : () -> vector<2xf64>
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_half_approx", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_intrinsic_half_fast", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.uitofp"(%arg0) : (i32) -> f64
    %2 = "llvm.call"(%1, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_half_no_FMF_base_ninf", type = !llvm.func<f64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_half_ninf", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<5.000000e-01> : vector<2xf64>} : () -> vector<2xf64>
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_half_ninf", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_half_nsz", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_half_nsz", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_half_ninf_nsz", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_half_ninf_nsz", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_half_fast", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_half_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5.000000e-01 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_neghalf_no_FMF", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5.000000e-01 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_neghalf_reassoc_ninf", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5.000000e-01 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_neghalf_afn", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-5.000000e-01> : vector<2xf64>} : () -> vector<2xf64>
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_neghalf_no_FMF", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-5.000000e-01> : vector<2xf64>} : () -> vector<2xf64>
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_neghalf_reassoc", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-5.000000e-01> : vector<2xf64>} : () -> vector<2xf64>
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_neghalf_afn", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_neghalf_ninf", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-5.000000e-01> : vector<2xf64>} : () -> vector<2xf64>
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.v2f64, fastmathFlags = #llvm.fastmath<>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    "llvm.return"(%1) : (vector<2xf64>) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_neghalf_ninf", type = !llvm.func<vector<2xf64> (vector<2xf64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_neghalf_nsz", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_neghalf_nsz", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_neghalf_ninf_nsz", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5.000000e-01 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_neghalf_ninf_nsz", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5.000000e-01 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_neghalf_fast", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_neghalf_fast", type = !llvm.func<f64 (f64)>} : () -> ()
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
  }) {linkage = 10 : i64, sym_name = "powf", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
