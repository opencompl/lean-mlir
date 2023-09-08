"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2.000000e+00 : f32} : () -> f32
    %1 = "llvm.call"(%0) {callee = @acosf, fastmathFlags = #llvm.fastmath<>} : (f32) -> f32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "acosf", type = !llvm.func<f32 (f32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
