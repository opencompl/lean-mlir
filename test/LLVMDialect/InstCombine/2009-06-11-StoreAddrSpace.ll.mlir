"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<i32, 1>
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.store"(%1, %0) : (i32, !llvm.ptr<i32, 1>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "a", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
