"module"() ( {
  "llvm.mlir.global"() ( {
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 4 : i64, sym_name = "p", type = !llvm.ptr<i8>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 999999 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @p} : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.mlir.constant"() {value = 1000 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.addressof"() {global_name = @p} : () -> !llvm.ptr<ptr<i8>>
    %5 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %6 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %7 = "llvm.call"() {callee = @llvm.stacksave, fastmathFlags = #llvm.fastmath<>} : () -> !llvm.ptr<i8>
    %8 = "llvm.alloca"(%6) : (i32) -> !llvm.ptr<i32>
    %9 = "llvm.bitcast"(%8) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.store"(%5, %8) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%9, %4) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    "llvm.br"(%3, %7)[^bb2] : (i32, !llvm.ptr<i8>) -> ()
  ^bb1:  // pred: ^bb2
    "llvm.return"(%3) : (i32) -> ()
  ^bb2(%10: i32, %11: !llvm.ptr<i8>):  // 2 preds: ^bb0, ^bb2
    %12 = "llvm.add"(%10, %6) : (i32, i32) -> i32
    "llvm.call"(%11) {callee = @llvm.stackrestore, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    %13 = "llvm.call"() {callee = @llvm.stacksave, fastmathFlags = #llvm.fastmath<>} : () -> !llvm.ptr<i8>
    %14 = "llvm.srem"(%12, %2) : (i32, i32) -> i32
    %15 = "llvm.add"(%14, %6) : (i32, i32) -> i32
    %16 = "llvm.alloca"(%15) : (i32) -> !llvm.ptr<i32>
    %17 = "llvm.bitcast"(%16) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.store"(%6, %16) : (i32, !llvm.ptr<i32>) -> ()
    %18 = "llvm.getelementptr"(%16, %14) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    "llvm.store"(%5, %18) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%17, %1) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %19 = "llvm.icmp"(%12, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%19, %12, %13)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 2]> : vector<3xi32>} : (i1, i32, !llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.stacksave", type = !llvm.func<ptr<i8> ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.stackrestore", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
