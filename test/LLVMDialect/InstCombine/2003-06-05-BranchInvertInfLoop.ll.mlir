"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = true} : () -> i1
    "llvm.cond_br"(%2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.return"(%1) : (i8) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.return"(%0) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "test19", type = !llvm.func<i8 (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
