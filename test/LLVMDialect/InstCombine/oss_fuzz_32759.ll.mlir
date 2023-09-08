"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 123 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 2147483647 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    "llvm.cond_br"(%arg1, %3)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    %4 = "llvm.zext"(%arg0) : (i1) -> i32
    %5 = "llvm.shl"(%4, %2) : (i32, i32) -> i32
    %6 = "llvm.ashr"(%5, %2) : (i32, i32) -> i32
    %7 = "llvm.srem"(%6, %1) : (i32, i32) -> i32
    %8 = "llvm.xor"(%7, %6) : (i32, i32) -> i32
    "llvm.br"(%8)[^bb2] : (i32) -> ()
  ^bb2(%9: i32):  // 2 preds: ^bb0, ^bb1
    %10 = "llvm.icmp"(%9, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%10) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "oss_fuzz_32759", type = !llvm.func<i1 (i1, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
