"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 1 : i64, sym_name = "Q", type = f64, value = 1.000000e+00 : f64} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @Q} : () -> !llvm.ptr<f64>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<f64>) -> !llvm.ptr<i64>
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    "llvm.cond_br"(%arg0, %2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.load"(%1) : (!llvm.ptr<i64>) -> i64
    "llvm.br"(%3)[^bb2] : (i64) -> ()
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    "llvm.store"(%4, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    %5 = "llvm.bitcast"(%4) : (i64) -> f64
    "llvm.return"(%5) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<f64 (i1, ptr<i64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
