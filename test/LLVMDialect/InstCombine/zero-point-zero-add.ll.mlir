"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fabs", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.000000e+00 : f64} : () -> f64
    %1 = "llvm.fadd"(%arg0, %0) : (f64, f64) -> f64
    %2 = "llvm.fadd"(%1, %0) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<f64 (f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%arg0) {callee = @fabs, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    %2 = "llvm.fadd"(%1, %0) : (f64, f64) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<f64 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
