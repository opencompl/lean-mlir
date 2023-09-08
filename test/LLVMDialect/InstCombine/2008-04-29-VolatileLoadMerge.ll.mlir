"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 1 : i64, sym_name = "g_1", type = i32, value = 0 : i32} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @g_1} : () -> !llvm.ptr<i32>
    %1 = "llvm.mlir.addressof"() {global_name = @g_1} : () -> !llvm.ptr<i32>
    %2 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %3 = "llvm.icmp"(%arg0, %2) {predicate = 2 : i64} : (i32, i32) -> i1
    %4 = "llvm.load"(%1) : (!llvm.ptr<i32>) -> i32
    "llvm.cond_br"(%3, %4)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    %5 = "llvm.load"(%0) : (!llvm.ptr<i32>) -> i32
    "llvm.br"(%5)[^bb2] : (i32) -> ()
  ^bb2(%6: i32):  // 2 preds: ^bb0, ^bb1
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
