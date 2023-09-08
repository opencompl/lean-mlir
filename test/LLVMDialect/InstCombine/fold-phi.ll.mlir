"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0.000000e+00 : f32} : () -> f32
    "llvm.br"(%0)[^bb1] : (f32) -> ()
  ^bb1(%1: f32):  // 2 preds: ^bb0, ^bb2
    %2 = "llvm.fadd"(%1, %arg0) : (f32, f32) -> f32
    "llvm.cond_br"(%arg1)[^bb2, ^bb3] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.br"(%2)[^bb1] : (f32) -> ()
  ^bb3:  // pred: ^bb1
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "no_crash", type = !llvm.func<f32 (f32, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4294967295 : i64} : () -> i64
    %1 = "llvm.mlir.undef"() : () -> i64
    "llvm.br"(%1)[^bb1] : (i64) -> ()
  ^bb1(%2: i64):  // 2 preds: ^bb0, ^bb3
    %3 = "llvm.zext"(%arg0) : (i32) -> i64
    "llvm.cond_br"(%arg1, %1)[^bb3, ^bb2] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb2:  // pred: ^bb1
    %4 = "llvm.or"(%2, %3) : (i64, i64) -> i64
    %5 = "llvm.and"(%4, %0) : (i64, i64) -> i64
    "llvm.br"(%5)[^bb3] : (i64) -> ()
  ^bb3(%6: i64):  // 2 preds: ^bb1, ^bb2
    %7 = "llvm.or"(%6, %3) : (i64, i64) -> i64
    "llvm.br"(%7)[^bb1] : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "pr21377", type = !llvm.func<void (i32, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
