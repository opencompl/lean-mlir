"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.and"(%2, %0) : (i8, i8) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "test21", type = !llvm.func<i8 (i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
