"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "escape", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i32>
    "llvm.cond_br"(%arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.store"(%1, %2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    "llvm.store"(%0, %2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %3 = "llvm.load"(%2) : (!llvm.ptr<i32>) -> i32
    %4 = "llvm.call"(%3) {callee = @escape, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
