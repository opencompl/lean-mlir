"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "readnone_but_may_throw", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 20 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    "llvm.store"(%1, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.call"() {callee = @readnone_but_may_throw, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.store"(%0, %arg0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "f_0", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 20 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    "llvm.store"(%1, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.call"() {callee = @readnone_but_may_throw, fastmathFlags = #llvm.fastmath<>} : () -> ()
    "llvm.cond_br"(%arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.store"(%0, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "f_1", type = !llvm.func<void (i1, ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
