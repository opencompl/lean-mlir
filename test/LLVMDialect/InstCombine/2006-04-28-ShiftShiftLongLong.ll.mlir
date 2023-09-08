"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %1 = "llvm.shl"(%arg0, %0) : (i64, i64) -> i64
    %2 = "llvm.ashr"(%1, %0) : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i64 (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
