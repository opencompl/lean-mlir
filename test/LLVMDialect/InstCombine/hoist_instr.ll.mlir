"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 15 : i32} : () -> i32
    "llvm.cond_br"(%arg0, %1)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg1)[^bb2] : (i32) -> ()
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = "llvm.sdiv"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 (i1, i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
