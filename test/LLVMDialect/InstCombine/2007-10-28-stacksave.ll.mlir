"module"() ( {
  "llvm.mlir.global"() ( {
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 4 : i64, sym_name = "p", type = !llvm.ptr<i8>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 999999 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @p} : () -> !llvm.ptr<ptr<i8>>
    %3 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %6 = "llvm.mlir.constant"() {value = 47 : i32} : () -> i32
    %7 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %8 = "llvm.bitcast"(%7) : (i32) -> i32
    "llvm.br"(%7)[^bb1] : (i32) -> ()
  ^bb1(%9: i32):  // 2 preds: ^bb0, ^bb3
    %10 = "llvm.call"() {callee = @llvm.stacksave, fastmathFlags = #llvm.fastmath<>} : () -> !llvm.ptr<i8>
    %11 = "llvm.srem"(%9, %6) : (i32, i32) -> i32
    %12 = "llvm.add"(%11, %5) : (i32, i32) -> i32
    %13 = "llvm.sub"(%12, %5) : (i32, i32) -> i32
    %14 = "llvm.zext"(%12) : (i32) -> i64
    %15 = "llvm.mul"(%14, %4) : (i64, i64) -> i64
    %16 = "llvm.mul"(%12, %3) : (i32, i32) -> i32
    %17 = "llvm.zext"(%12) : (i32) -> i64
    %18 = "llvm.mul"(%17, %4) : (i64, i64) -> i64
    %19 = "llvm.mul"(%12, %3) : (i32, i32) -> i32
    %20 = "llvm.alloca"(%19) : (i32) -> !llvm.ptr<i8>
    %21 = "llvm.bitcast"(%20) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    %22 = "llvm.getelementptr"(%21, %7) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%5, %22) : (i32, !llvm.ptr<i32>) -> ()
    %23 = "llvm.bitcast"(%21) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.store"(%23, %2) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %24 = "llvm.add"(%9, %5) : (i32, i32) -> i32
    %25 = "llvm.icmp"(%24, %1) {predicate = 3 : i64} : (i32, i32) -> i1
    %26 = "llvm.zext"(%25) : (i1) -> i8
    %27 = "llvm.icmp"(%26, %0) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.cond_br"(%27)[^bb3, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.call"(%10) {callee = @llvm.stackrestore, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"(%7) : (i32) -> ()
  ^bb3:  // pred: ^bb1
    "llvm.call"(%10) {callee = @llvm.stackrestore, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.br"(%24)[^bb1] : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.stacksave", type = !llvm.func<ptr<i8> ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.stackrestore", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
