"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1648 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = 63 : i64} : () -> i64
    %5 = "llvm.ptrtoint"(%arg0) : (!llvm.ptr<i32>) -> i64
    %6 = "llvm.and"(%5, %4) : (i64, i64) -> i64
    %7 = "llvm.icmp"(%6, %3) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.call"(%7) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %8 = "llvm.ptrtoint"(%arg1) : (!llvm.ptr<i32>) -> i64
    %9 = "llvm.and"(%8, %4) : (i64, i64) -> i64
    %10 = "llvm.icmp"(%9, %3) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.call"(%10) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.br"(%3)[^bb1] : (i64) -> ()
  ^bb1(%11: i64):  // 2 preds: ^bb0, ^bb1
    %12 = "llvm.getelementptr"(%arg1, %11) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %13 = "llvm.load"(%12) : (!llvm.ptr<i32>) -> i32
    %14 = "llvm.add"(%13, %2) : (i32, i32) -> i32
    %15 = "llvm.getelementptr"(%arg0, %11) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%14, %15) : (i32, !llvm.ptr<i32>) -> ()
    %16 = "llvm.add"(%11, %1) : (i64, i64) -> i64
    %17 = "llvm.trunc"(%16) : (i64) -> i32
    %18 = "llvm.icmp"(%17, %0) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%18, %16)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.assume", type = !llvm.func<void (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
