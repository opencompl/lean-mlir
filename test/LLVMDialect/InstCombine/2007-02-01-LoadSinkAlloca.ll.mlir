"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 123 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i32>
    %4 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i32>
    %5 = "llvm.call"(%3) {callee = @bar, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>) -> i32
    %6 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    %7 = "llvm.icmp"(%arg0, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%7, %6)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.store"(%0, %4) : (i32, !llvm.ptr<i32>) -> ()
    %8 = "llvm.call"(%0) {callee = @test2, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %9 = "llvm.load"(%4) : (!llvm.ptr<i32>) -> i32
    "llvm.br"(%9)[^bb2] : (i32) -> ()
  ^bb2(%10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %12 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %13 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %14 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %15 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %16 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %17 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %18 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %19 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %20 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %21 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %22 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %23 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %24 = "llvm.call"() {callee = @baq, fastmathFlags = #llvm.fastmath<>} : () -> i32
    "llvm.return"(%10) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<i32 (...)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "baq", type = !llvm.func<i32 (...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
