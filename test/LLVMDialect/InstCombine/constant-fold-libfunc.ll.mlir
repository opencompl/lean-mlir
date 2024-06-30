"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "acos", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -1.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @acos, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify_acos", type = !llvm.func<f64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -1.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @acos, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_acos_nobuiltin", type = !llvm.func<f64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -1.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @acos, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_acos_strictfp", type = !llvm.func<f64 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
