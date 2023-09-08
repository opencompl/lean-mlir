"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -81 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = -2 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    "llvm.cond_br"(%arg0, %2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.ashr"(%arg1, %1) : (i32, i32) -> i32
    %4 = "llvm.sext"(%3) : (i32) -> i64
    "llvm.br"(%4)[^bb2] : (i64) -> ()
  ^bb2(%5: i64):  // 2 preds: ^bb0, ^bb1
    %6 = "llvm.and"(%0, %5) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "PR56424", type = !llvm.func<i64 (i1, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
