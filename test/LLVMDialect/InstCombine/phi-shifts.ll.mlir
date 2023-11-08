"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: !llvm.ptr<i8>, %arg2: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 170141183460469231731687303715884105727 : i128} : () -> i128
    %1 = "llvm.mlir.constant"() {value = 64 : i128} : () -> i128
    %2 = "llvm.mlir.constant"() {value = 18446744073709551616 : i128} : () -> i128
    %3 = "llvm.mlir.constant"() {value = 0 : i128} : () -> i128
    "llvm.cond_br"(%arg0, %3)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i128) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%2)[^bb2] : (i128) -> ()
  ^bb2(%4: i128):  // 2 preds: ^bb0, ^bb1
    %5 = "llvm.lshr"(%4, %1) : (i128, i128) -> i128
    %6 = "llvm.lshr"(%5, %0) : (i128, i128) -> i128
    %7 = "llvm.trunc"(%6) : (i128) -> i64
    "llvm.return"(%7) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fuzz15217", type = !llvm.func<i64 (i1, ptr<i8>, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
