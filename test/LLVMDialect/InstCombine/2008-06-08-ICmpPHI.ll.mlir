"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 37 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.br"(%3, %2)[^bb1] : (i32, i32) -> ()
  ^bb1(%4: i32, %5: i32):  // 2 preds: ^bb0, ^bb6
    %6 = "llvm.call"() {callee = @bork, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %7 = "llvm.call"() {callee = @bork, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %8 = "llvm.call"() {callee = @bork, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %9 = "llvm.icmp"(%8, %3) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%9)[^bb3, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %10 = "llvm.call"() {callee = @bork, fastmathFlags = #llvm.fastmath<>} : () -> i32
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %11 = "llvm.call"() {callee = @bork, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %12 = "llvm.call"() {callee = @bork, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %13 = "llvm.icmp"(%5, %2) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%13)[^bb4, ^bb5] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb4:  // pred: ^bb3
    %14 = "llvm.call"() {callee = @bar, fastmathFlags = #llvm.fastmath<>} : () -> i32
    "llvm.br"()[^bb5] : () -> ()
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %15 = "llvm.call"() {callee = @zap, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %16 = "llvm.add"(%4, %1) : (i32, i32) -> i32
    %17 = "llvm.icmp"(%16, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%17)[^bb7, ^bb6] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "llvm.br"(%16, %15)[^bb1] : (i32, i32) -> ()
  ^bb7:  // pred: ^bb5
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bork", type = !llvm.func<i32 (...)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<i32 (...)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "zap", type = !llvm.func<i32 (...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
