"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = -29 : i32} : () -> i32
    "llvm.br"(%3)[^bb1] : (i32) -> ()
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb1
    %5 = "llvm.srem"(%4, %2) : (i32, i32) -> i32
    %6 = "llvm.icmp"(%5, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%6, %0)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
