"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "t1", type = !llvm.func<f64 (i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @t1, fastmathFlags = #llvm.fastmath<>} : (i32) -> f64
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "t2", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
