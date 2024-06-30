"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.call"() {callee = @bar, fastmathFlags = #llvm.fastmath<>} : () -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 1 : i64, sym_name = "bar", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
