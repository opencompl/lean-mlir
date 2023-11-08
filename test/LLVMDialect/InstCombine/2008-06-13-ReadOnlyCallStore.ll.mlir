"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    "llvm.store"(%1, %arg0) : (i8, !llvm.ptr<i8>) -> ()
    %2 = "llvm.call"(%arg0) {callee = @strlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i32
    %3 = "llvm.icmp"(%2, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%3)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.store"(%1, %arg0) : (i8, !llvm.ptr<i8>) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "a", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strlen", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
