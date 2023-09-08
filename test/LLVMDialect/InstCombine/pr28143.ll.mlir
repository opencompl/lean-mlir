"module"() ( {
  "llvm.func"() ( {
    "llvm.call"() {callee = @tan, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "tan", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
