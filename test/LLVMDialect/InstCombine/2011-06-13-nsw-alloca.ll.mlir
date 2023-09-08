"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2048 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.null"() : () -> !llvm.ptr<f64>
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<i32>
    %6 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<ptr<f64>>
    "llvm.store"(%arg0, %5) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%3, %6) : (!llvm.ptr<f64>, !llvm.ptr<ptr<f64>>) -> ()
    %7 = "llvm.load"(%5) : (!llvm.ptr<i32>) -> i32
    %8 = "llvm.icmp"(%7, %2) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%8)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %9 = "llvm.load"(%5) : (!llvm.ptr<i32>) -> i32
    %10 = "llvm.shl"(%9, %1) : (i32, i32) -> i32
    %11 = "llvm.add"(%10, %0) : (i32, i32) -> i32
    %12 = "llvm.alloca"(%11) : (i32) -> !llvm.ptr<i8>
    %13 = "llvm.bitcast"(%12) : (!llvm.ptr<i8>) -> !llvm.ptr<f64>
    "llvm.store"(%13, %6) : (!llvm.ptr<f64>, !llvm.ptr<ptr<f64>>) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %14 = "llvm.load"(%6) : (!llvm.ptr<ptr<f64>>) -> !llvm.ptr<f64>
    "llvm.call"(%14) {callee = @bar, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<f64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fu1", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<void (ptr<f64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2048 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.null"() : () -> !llvm.ptr<f64>
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<i32>
    %6 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<ptr<f64>>
    "llvm.store"(%arg0, %5) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%3, %6) : (!llvm.ptr<f64>, !llvm.ptr<ptr<f64>>) -> ()
    %7 = "llvm.load"(%5) : (!llvm.ptr<i32>) -> i32
    %8 = "llvm.icmp"(%7, %2) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%8)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %9 = "llvm.load"(%5) : (!llvm.ptr<i32>) -> i32
    %10 = "llvm.mul"(%9, %1) : (i32, i32) -> i32
    %11 = "llvm.add"(%10, %0) : (i32, i32) -> i32
    %12 = "llvm.alloca"(%11) : (i32) -> !llvm.ptr<i8>
    %13 = "llvm.bitcast"(%12) : (!llvm.ptr<i8>) -> !llvm.ptr<f64>
    "llvm.store"(%13, %6) : (!llvm.ptr<f64>, !llvm.ptr<ptr<f64>>) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %14 = "llvm.load"(%6) : (!llvm.ptr<ptr<f64>>) -> !llvm.ptr<f64>
    "llvm.call"(%14) {callee = @bar, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<f64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fu2", type = !llvm.func<void (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
