"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.undef"() : () -> i32
    %2 = "llvm.mlir.constant"() {value = true} : () -> i1
    %3 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %4 = "llvm.icmp"(%arg0, %3) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.call"(%4) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.cond_br"(%2, %1)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    %5 = "llvm.shl"(%arg0, %0) : (i32, i32) -> i32
    "llvm.br"(%5)[^bb2] : (i32) -> ()
  ^bb2(%6: i32):  // 2 preds: ^bb0, ^bb1
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.assume", type = !llvm.func<void (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
