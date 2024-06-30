"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "cond", type = !llvm.func<i1 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 99 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.br"(%2)[^bb1] : (i32) -> ()
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb4
    %4 = "llvm.call"() {callee = @cond, fastmathFlags = #llvm.fastmath<>} : () -> i1
    "llvm.cond_br"(%4)[^bb2, ^bb5] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %5 = "llvm.add"(%3, %1) : (i32, i32) -> i32
    "llvm.cond_br"(%4, %5)[^bb3, ^bb4] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb3(%6: i32):  // 2 preds: ^bb2, ^bb3
    %7 = "llvm.icmp"(%6, %0) {predicate = 3 : i64} : (i32, i32) -> i1
    %8 = "llvm.add"(%6, %1) : (i32, i32) -> i32
    "llvm.cond_br"(%7, %8)[^bb3, ^bb5] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb4:  // pred: ^bb2
    "llvm.br"(%5)[^bb1] : (i32) -> ()
  ^bb5:  // 2 preds: ^bb1, ^bb3
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "phi_recurrence_start_first", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 99 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.br"(%2)[^bb1] : (i32) -> ()
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb4
    %4 = "llvm.call"() {callee = @cond, fastmathFlags = #llvm.fastmath<>} : () -> i1
    "llvm.cond_br"(%4)[^bb2, ^bb5] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %5 = "llvm.add"(%3, %1) : (i32, i32) -> i32
    "llvm.cond_br"(%4, %5)[^bb3, ^bb4] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb3(%6: i32):  // 2 preds: ^bb2, ^bb3
    %7 = "llvm.icmp"(%6, %0) {predicate = 3 : i64} : (i32, i32) -> i1
    %8 = "llvm.add"(%6, %1) : (i32, i32) -> i32
    "llvm.cond_br"(%7, %8)[^bb3, ^bb5] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb4:  // pred: ^bb2
    "llvm.br"(%5)[^bb1] : (i32) -> ()
  ^bb5:  // 2 preds: ^bb1, ^bb3
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "phi_recurrence_step_first", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
