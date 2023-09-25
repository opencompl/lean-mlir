"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.33333333333333331 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_third_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.333333343 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_intrinsic_third_fast", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.33333333333333331 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_third_approx", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.333333343 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_intrinsic_third_approx", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.33333333333333331 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_third_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.333333343 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_libcall_third_fast", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -0.33333333333333331 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_negthird_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -0.333333343 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_intrinsic_negthird_fast", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -0.33333333333333331 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_intrinsic_negthird_approx", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -0.333333343 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f32, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_intrinsic_negthird_approx", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -0.33333333333333331 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "pow_libcall_negthird_fast", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -0.333333343 : f32} : () -> f32
    %1 = "llvm.call"(%arg0, %0) {callee = @powf, fastmathFlags = #llvm.fastmath<>} : (f32, f32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "powf_libcall_negthird_fast", type = !llvm.func<f32 (f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.f64", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.f32", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "pow", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "powf", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
