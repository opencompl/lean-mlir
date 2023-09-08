"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.assume", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = true} : () -> i1
    %3 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %6 = "llvm.getelementptr"(%arg0, %5) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %7 = "llvm.ptrtoint"(%6) : (!llvm.ptr<i8>) -> i64
    %8 = "llvm.and"(%7, %4) : (i64, i64) -> i64
    %9 = "llvm.icmp"(%8, %3) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%9)[^bb1, ^bb4] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.call"(%2) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %10 = "llvm.ptrtoint"(%6) : (!llvm.ptr<i8>) -> i64
    %11 = "llvm.and"(%10, %4) : (i64, i64) -> i64
    %12 = "llvm.icmp"(%11, %3) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%12)[^bb2, ^bb3] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %13 = "llvm.bitcast"(%6) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    "llvm.store"(%1, %13) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.br"()[^bb4] : () -> ()
  ^bb3:  // pred: ^bb1
    "llvm.store"(%0, %6) : (i8, !llvm.ptr<i8>) -> ()
    "llvm.br"()[^bb4] : () -> ()
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "f1", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 15 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = true} : () -> i1
    "llvm.call"(%5) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %6 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %7 = "llvm.ptrtoint"(%6) : (!llvm.ptr<i8>) -> i64
    %8 = "llvm.and"(%7, %3) : (i64, i64) -> i64
    %9 = "llvm.icmp"(%8, %2) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%9)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %10 = "llvm.bitcast"(%6) : (!llvm.ptr<i8>) -> !llvm.ptr<i64>
    "llvm.store"(%1, %10) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    "llvm.store"(%0, %6) : (i8, !llvm.ptr<i8>) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "f2", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.ptrtoint"(%arg1) : (!llvm.ptr<i8>) -> i64
    "llvm.call"(%0) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %2 = "llvm.add"(%arg0, %1) : (i64, i64) -> i64
    "llvm.call"(%2) {callee = @g, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "f3", type = !llvm.func<void (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "g", type = !llvm.func<void (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    "llvm.call"(%0) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i8>) -> i8
    "llvm.return"(%1) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "assume_align_zero", type = !llvm.func<i8 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    "llvm.call"(%0) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i8>) -> i8
    "llvm.return"(%1) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "assume_align_non_pow2", type = !llvm.func<i8 (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
