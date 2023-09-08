"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "a", type = i64, value = 0 : i64} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "d", type = i64, value = 0 : i64} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "c", type = i8} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i16>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @c} : () -> !llvm.ptr<i8>
    %1 = "llvm.mlir.addressof"() {global_name = @c} : () -> !llvm.ptr<i8>
    %2 = "llvm.mlir.addressof"() {global_name = @c} : () -> !llvm.ptr<i8>
    %3 = "llvm.mlir.addressof"() {global_name = @c} : () -> !llvm.ptr<i8>
    %4 = "llvm.mlir.addressof"() {global_name = @c} : () -> !llvm.ptr<i8>
    %5 = "llvm.mlir.addressof"() {global_name = @c} : () -> !llvm.ptr<i8>
    %6 = "llvm.mlir.addressof"() {global_name = @c} : () -> !llvm.ptr<i8>
    %7 = "llvm.mlir.addressof"() {global_name = @c} : () -> !llvm.ptr<i8>
    %8 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<i64>
    %9 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %10 = "llvm.mlir.addressof"() {global_name = @d} : () -> !llvm.ptr<i64>
    %11 = "llvm.load"(%10) : (!llvm.ptr<i64>) -> i64
    %12 = "llvm.icmp"(%11, %9) {predicate = 0 : i64} : (i64, i64) -> i1
    %13 = "llvm.load"(%8) : (!llvm.ptr<i64>) -> i64
    %14 = "llvm.icmp"(%13, %9) {predicate = 1 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%12)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %15 = "llvm.load"(%arg0) : (!llvm.ptr<i16>) -> i16
    %16 = "llvm.trunc"(%15) : (i16) -> i8
    "llvm.store"(%16, %7) : (i8, !llvm.ptr<i8>) -> ()
    "llvm.call"(%14) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %17 = "llvm.load"(%arg0) : (!llvm.ptr<i16>) -> i16
    %18 = "llvm.trunc"(%17) : (i16) -> i8
    "llvm.store"(%18, %6) : (i8, !llvm.ptr<i8>) -> ()
    %19 = "llvm.load"(%arg0) : (!llvm.ptr<i16>) -> i16
    %20 = "llvm.trunc"(%19) : (i16) -> i8
    "llvm.store"(%20, %5) : (i8, !llvm.ptr<i8>) -> ()
    %21 = "llvm.load"(%arg0) : (!llvm.ptr<i16>) -> i16
    %22 = "llvm.trunc"(%21) : (i16) -> i8
    "llvm.store"(%22, %4) : (i8, !llvm.ptr<i8>) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    %23 = "llvm.load"(%arg0) : (!llvm.ptr<i16>) -> i16
    %24 = "llvm.trunc"(%23) : (i16) -> i8
    "llvm.store"(%24, %3) : (i8, !llvm.ptr<i8>) -> ()
    %25 = "llvm.load"(%arg0) : (!llvm.ptr<i16>) -> i16
    %26 = "llvm.trunc"(%25) : (i16) -> i8
    "llvm.store"(%26, %2) : (i8, !llvm.ptr<i8>) -> ()
    %27 = "llvm.load"(%arg0) : (!llvm.ptr<i16>) -> i16
    %28 = "llvm.trunc"(%27) : (i16) -> i8
    "llvm.store"(%28, %1) : (i8, !llvm.ptr<i8>) -> ()
    %29 = "llvm.load"(%arg0) : (!llvm.ptr<i16>) -> i16
    %30 = "llvm.trunc"(%29) : (i16) -> i8
    "llvm.store"(%30, %0) : (i8, !llvm.ptr<i8>) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "llvm.br"()[^bb4] : () -> ()
  ^bb4:  // 2 preds: ^bb3, ^bb4
    "llvm.br"()[^bb4] : () -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<void (ptr<i16>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.assume", type = !llvm.func<void (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
