"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = -1 : i16} : () -> i16
    %4 = "llvm.mlir.constant"() {value = 1 : i16} : () -> i16
    %5 = "llvm.mlir.null"() : () -> !llvm.ptr<i16>
    %6 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %7 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %8 = "llvm.icmp"(%7, %6) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%8)[^bb1, ^bb5] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%7, %7)[^bb3] : (i32, i32) -> ()
  ^bb2:  // pred: ^bb3
    %9 = "llvm.load"(%5) : (!llvm.ptr<i16>) -> i16
    %10 = "llvm.icmp"(%9, %4) {predicate = 6 : i64} : (i16, i16) -> i1
    %11 = "llvm.icmp"(%9, %3) {predicate = 8 : i64} : (i16, i16) -> i1
    %12 = "llvm.or"(%10, %11) : (i1, i1) -> i1
    %13 = "llvm.zext"(%12) : (i1) -> i32
    %14 = "llvm.xor"(%13, %2) : (i32, i32) -> i32
    %15 = "llvm.add"(%17, %14) : (i32, i32) -> i32
    %16 = "llvm.add"(%18, %1) : (i32, i32) -> i32
    "llvm.br"(%15, %16)[^bb3] : (i32, i32) -> ()
  ^bb3(%17: i32, %18: i32):  // 2 preds: ^bb1, ^bb2
    %19 = "llvm.icmp"(%18, %7) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%19)[^bb2, ^bb4] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb4:  // pred: ^bb3
    "llvm.return"(%7) : (i32) -> ()
  ^bb5:  // pred: ^bb0
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
