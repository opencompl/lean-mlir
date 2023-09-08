"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i80} : () -> i80
    %1 = "llvm.bitcast"(%0) : (i80) -> f80
    "llvm.return"(%1) : (f80) -> ()
  }) {linkage = 10 : i64, sym_name = "cast", type = !llvm.func<f80 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0.000000e+00 : f32} : () -> f80
    %1 = "llvm.bitcast"(%0) : (f80) -> i80
    "llvm.return"(%1) : (i80) -> ()
  }) {linkage = 10 : i64, sym_name = "invcast", type = !llvm.func<i80 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
