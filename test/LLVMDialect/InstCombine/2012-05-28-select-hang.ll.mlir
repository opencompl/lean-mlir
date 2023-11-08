"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 5 : i64, sym_name = "c", type = i8, value = 0 : i8} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 5 : i64, sym_name = "a", type = i8, value = 0 : i8} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 5 : i64, sym_name = "b", type = i8, value = 0 : i8} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<i8>
    %1 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = false} : () -> i1
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<i8>
    %5 = "llvm.mlir.addressof"() {global_name = @b} : () -> !llvm.ptr<i8>
    %6 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %7 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<i8>
    %8 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %9 = "llvm.mlir.addressof"() {global_name = @c} : () -> !llvm.ptr<i8>
    %10 = "llvm.load"(%9) : (!llvm.ptr<i8>) -> i8
    %11 = "llvm.zext"(%10) : (i8) -> i32
    %12 = "llvm.or"(%11, %8) : (i32, i32) -> i32
    %13 = "llvm.trunc"(%12) : (i32) -> i8
    "llvm.store"(%13, %7) : (i8, !llvm.ptr<i8>) -> ()
    %14 = "llvm.zext"(%13) : (i8) -> i32
    %15 = "llvm.xor"(%14, %6) : (i32, i32) -> i32
    %16 = "llvm.and"(%8, %15) : (i32, i32) -> i32
    %17 = "llvm.trunc"(%16) : (i32) -> i8
    "llvm.store"(%17, %5) : (i8, !llvm.ptr<i8>) -> ()
    %18 = "llvm.load"(%4) : (!llvm.ptr<i8>) -> i8
    %19 = "llvm.zext"(%18) : (i8) -> i32
    %20 = "llvm.zext"(%17) : (i8) -> i32
    %21 = "llvm.icmp"(%19, %3) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%21, %2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i1) -> ()
  ^bb1:  // pred: ^bb0
    %22 = "llvm.icmp"(%20, %3) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.br"(%22)[^bb2] : (i1) -> ()
  ^bb2(%23: i1):  // 2 preds: ^bb0, ^bb1
    %24 = "llvm.zext"(%23) : (i1) -> i32
    %25 = "llvm.mul"(%1, %24) : (i32, i32) -> i32
    %26 = "llvm.trunc"(%25) : (i32) -> i8
    "llvm.store"(%26, %0) : (i8, !llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "func", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
