"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 5 : i64, sym_name = "b", type = i32, value = 0 : i32} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @b} : () -> !llvm.ptr<i32>
    %2 = "llvm.mlir.constant"() {value = 32 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %5 = "llvm.mlir.addressof"() {global_name = @b} : () -> !llvm.ptr<i32>
    %6 = "llvm.load"(%5) : (!llvm.ptr<i32>) -> i32
    "llvm.br"(%6, %4)[^bb1] : (i32, i32) -> ()
  ^bb1(%7: i32, %8: i32):  // 2 preds: ^bb0, ^bb1
    %9 = "llvm.lshr"(%7, %3) : (i32, i32) -> i32
    %10 = "llvm.or"(%9, %7) : (i32, i32) -> i32
    %11 = "llvm.add"(%8, %3) : (i32, i32) -> i32
    %12 = "llvm.icmp"(%11, %2) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%12, %10, %11)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 0, 2]> : vector<3xi32>} : (i1, i32, i32) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.store"(%10, %1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "fn1", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
