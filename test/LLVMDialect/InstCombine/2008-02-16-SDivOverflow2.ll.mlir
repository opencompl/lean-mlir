"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i8} : () -> i8
    %1 = "llvm.sdiv"(%arg0, %0) : (i8, i8) -> i8
    %2 = "llvm.sdiv"(%1, %0) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "i", type = !llvm.func<i8 (i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
