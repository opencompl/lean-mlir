"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i1):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i1) -> i64
    "llvm.cond_br"(%arg0, %0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "llvm.zext"(%arg1) : (i1) -> i64
    "llvm.br"(%1)[^bb2] : (i64) -> ()
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "sink_i1_casts", type = !llvm.func<i64 (i1, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
