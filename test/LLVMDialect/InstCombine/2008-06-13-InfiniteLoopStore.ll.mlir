"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "g_139", type = i32, value = 0 : i32} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @g_139} : () -> !llvm.ptr<i32>
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @g_139} : () -> !llvm.ptr<i32>
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.store"(%4, %3) : (i32, !llvm.ptr<i32>) -> ()
    %5 = "llvm.icmp"(%arg0, %2) {predicate = 1 : i64} : (i32, i32) -> i1
    %6 = "llvm.zext"(%5) : (i1) -> i8
    %7 = "llvm.icmp"(%6, %1) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.cond_br"(%7)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    "llvm.store"(%4, %0) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  ^bb2:  // pred: ^bb0
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "func_56", type = !llvm.func<void (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
