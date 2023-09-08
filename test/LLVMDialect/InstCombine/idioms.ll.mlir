"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.sub"(%1, %arg0) : (i32, i32) -> i32
    %4 = "llvm.sub"(%3, %0) : (i32, i32) -> i32
    %5 = "llvm.ashr"(%4, %arg1) : (i32, i32) -> i32
    %6 = "llvm.sub"(%1, %5) : (i32, i32) -> i32
    %7 = "llvm.sub"(%6, %0) : (i32, i32) -> i32
    "llvm.br"(%7)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %8 = "llvm.ashr"(%arg0, %arg1) : (i32, i32) -> i32
    "llvm.br"(%8)[^bb3] : (i32) -> ()
  ^bb3(%9: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.return"(%9) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_asr", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
