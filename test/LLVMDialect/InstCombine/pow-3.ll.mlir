"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.pow.f64", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "pow", type = !llvm.func<f64 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_libcall", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5.000000e-01 : f64} : () -> f64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "sqrt_intrinsic", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.fpext"(%arg1) : (f32) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "shrink_libcall", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32):  // no predecessors
    %0 = "llvm.fpext"(%arg0) : (f32) -> f64
    %1 = "llvm.fpext"(%arg1) : (f32) -> f64
    %2 = "llvm.call"(%0, %1) {callee = @llvm.pow.f64, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f64
    %3 = "llvm.fptrunc"(%2) : (f64) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "shrink_intrinsic", type = !llvm.func<f32 (f32, f32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
