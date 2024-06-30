"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "pow", type = !llvm.func<f32 (f64, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0, %arg0) {callee = @pow, fastmathFlags = #llvm.fastmath<>} : (f64, f64) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify1", type = !llvm.func<f32 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
