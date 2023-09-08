"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 1 : i64, sym_name = "g_1", type = i32, value = 0 : i32} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @g_1} : () -> !llvm.ptr<i32>
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @g_1} : () -> !llvm.ptr<i32>
    %3 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %4 = "llvm.mlir.addressof"() {global_name = @g_1} : () -> !llvm.ptr<i32>
    %5 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %6 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %7 = "llvm.icmp"(%6, %5) {predicate = 2 : i64} : (i32, i32) -> i1
    %8 = "llvm.load"(%4) : (!llvm.ptr<i32>) -> i32
    "llvm.br"(%6, %8)[^bb1] : (i32, i32) -> ()
  ^bb1(%9: i32, %10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = "llvm.add"(%10, %3) : (i32, i32) -> i32
    "llvm.store"(%11, %2) : (i32, !llvm.ptr<i32>) -> ()
    %12 = "llvm.add"(%9, %1) : (i32, i32) -> i32
    %13 = "llvm.icmp"(%12, %5) {predicate = 2 : i64} : (i32, i32) -> i1
    %14 = "llvm.load"(%0) : (!llvm.ptr<i32>) -> i32
    "llvm.cond_br"(%13, %12, %14)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 2, 0]> : vector<3xi32>} : (i1, i32, i32) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
