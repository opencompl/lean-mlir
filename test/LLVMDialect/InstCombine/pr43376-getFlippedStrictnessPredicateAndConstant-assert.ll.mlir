"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i16>, %arg1: !llvm.ptr<i16>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i16} : () -> i16
    %1 = "llvm.mlir.constant"() {value = 3 : i16} : () -> i16
    %2 = "llvm.mlir.constant"() {value = false} : () -> i1
    %3 = "llvm.mlir.constant"() {value = 0 : i16} : () -> i16
    %4 = "llvm.load"(%arg0) : (!llvm.ptr<i16>) -> i16
    %5 = "llvm.icmp"(%4, %3) {predicate = 1 : i64} : (i16, i16) -> i1
    "llvm.cond_br"(%5, %2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i1) -> ()
  ^bb1:  // pred: ^bb0
    %6 = "llvm.load"(%arg1) : (!llvm.ptr<i16>) -> i16
    %7 = "llvm.icmp"(%6, %3) {predicate = 6 : i64} : (i16, i16) -> i1
    "llvm.br"(%7)[^bb2] : (i1) -> ()
  ^bb2(%8: i1):  // 2 preds: ^bb0, ^bb1
    %9 = "llvm.zext"(%8) : (i1) -> i16
    %10 = "llvm.mul"(%9, %1) : (i16, i16) -> i16
    %11 = "llvm.xor"(%10, %0) : (i16, i16) -> i16
    "llvm.return"(%11) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "d", type = !llvm.func<i16 (ptr<i16>, ptr<i16>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
