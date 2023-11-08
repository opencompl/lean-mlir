"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0x7FF0000000000000 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @sin, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<f64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0.000000e+00 : f64} : () -> f64
    %1 = "llvm.call"(%0) {callee = @sin, fastmathFlags = #llvm.fastmath<>} : (f64) -> f64
    "llvm.return"(%1) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<f64 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sin", type = !llvm.func<f64 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
