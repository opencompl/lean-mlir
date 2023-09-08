"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"struct.s", (ptr<f64>)>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1599 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 2.000000e+00 : f64} : () -> f64
    %3 = "llvm.mlir.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %4 = "llvm.mlir.constant"() {value = 31 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %6 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %7 = "llvm.getelementptr"(%arg0, %6, %5) : (!llvm.ptr<struct<"struct.s", (ptr<f64>)>>, i64, i32) -> !llvm.ptr<ptr<f64>>
    %8 = "llvm.load"(%7) : (!llvm.ptr<ptr<f64>>) -> !llvm.ptr<f64>
    %9 = "llvm.ptrtoint"(%8) : (!llvm.ptr<f64>) -> i64
    %10 = "llvm.and"(%9, %4) : (i64, i64) -> i64
    %11 = "llvm.icmp"(%10, %6) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.br"(%6)[^bb1] : (i64) -> ()
  ^bb1(%12: i64):  // 2 preds: ^bb0, ^bb1
    "llvm.call"(%11) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %13 = "llvm.getelementptr"(%8, %12) : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %14 = "llvm.load"(%13) : (!llvm.ptr<f64>) -> f64
    %15 = "llvm.fadd"(%14, %3) : (f64, f64) -> f64
    "llvm.call"(%11) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %16 = "llvm.fmul"(%15, %2) : (f64, f64) -> f64
    "llvm.store"(%16, %13) : (f64, !llvm.ptr<f64>) -> ()
    %17 = "llvm.add"(%12, %1) : (i64, i64) -> i64
    "llvm.call"(%11) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %18 = "llvm.getelementptr"(%8, %17) : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %19 = "llvm.load"(%18) : (!llvm.ptr<f64>) -> f64
    %20 = "llvm.fadd"(%19, %3) : (f64, f64) -> f64
    "llvm.call"(%11) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %21 = "llvm.fmul"(%20, %2) : (f64, f64) -> f64
    "llvm.store"(%21, %18) : (f64, !llvm.ptr<f64>) -> ()
    %22 = "llvm.add"(%17, %1) : (i64, i64) -> i64
    %23 = "llvm.icmp"(%17, %0) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%23, %22)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "_Z3fooR1s", type = !llvm.func<void (ptr<struct<"struct.s", (ptr<f64>)>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "get", type = !llvm.func<ptr<i8> ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %2 = "llvm.call"() {callee = @get, fastmathFlags = #llvm.fastmath<>} : () -> !llvm.ptr<i8>
    %3 = "llvm.ptrtoint"(%2) : (!llvm.ptr<i8>) -> i64
    %4 = "llvm.and"(%3, %1) : (i64, i64) -> i64
    %5 = "llvm.icmp"(%4, %0) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.call"(%5) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i8>
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr<i8>) -> i64
    %5 = "llvm.and"(%4, %1) : (i64, i64) -> i64
    %6 = "llvm.icmp"(%5, %0) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.call"(%6) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.assume", type = !llvm.func<void (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
