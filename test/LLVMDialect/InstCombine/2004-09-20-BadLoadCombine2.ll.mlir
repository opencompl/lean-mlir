"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i32>
    %4 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i32>
    "llvm.store"(%2, %3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%1, %4) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.cond_br"(%arg0, %4)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, !llvm.ptr<i32>) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%3)[^bb2] : (!llvm.ptr<i32>) -> ()
  ^bb2(%5: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    "llvm.store"(%0, %3) : (i32, !llvm.ptr<i32>) -> ()
    %6 = "llvm.load"(%5) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
