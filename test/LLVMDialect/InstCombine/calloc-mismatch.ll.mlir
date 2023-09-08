"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "calloc", type = !llvm.func<ptr<i8> (i64, i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %2 = "llvm.call"(%1, %0) {callee = @calloc, fastmathFlags = #llvm.fastmath<>} : (i64, i32) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "PR50846", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
