"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.sdiv"(%arg1, %arg2) : (i32, i32) -> i32
    %1 = "llvm.add"(%arg2, %arg1) : (i32, i32) -> i32
    "llvm.cond_br"(%arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.return"(%1) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (i1, i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
