"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i16>):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr<i8>
    %1 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 0 : i16} : () -> i16
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %4 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<i16>, i32) -> !llvm.ptr<i16>
    %5 = "llvm.load"(%4) : (!llvm.ptr<i16>) -> i16
    %6 = "llvm.icmp"(%5, %2) {predicate = 0 : i64} : (i16, i16) -> i1
    "llvm.cond_br"(%6, %5)[^bb2, ^bb3] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i16) -> ()
  ^bb2:  // pred: ^bb1
    %7 = "llvm.load"(%4) : (!llvm.ptr<i16>) -> i16
    "llvm.br"(%7)[^bb3] : (i16) -> ()
  ^bb3(%8: i16):  // 2 preds: ^bb1, ^bb2
    %9 = "llvm.trunc"(%8) : (i16) -> i8
    %10 = "llvm.add"(%9, %1) : (i8, i8) -> i8
    "llvm.store"(%10, %0) : (i8, !llvm.ptr<i8>) -> ()
    "llvm.br"()[^bb1] : () -> ()
  }) {linkage = 10 : i64, sym_name = "timeout", type = !llvm.func<void (ptr<i16>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
