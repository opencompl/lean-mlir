"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: !llvm.ptr<f32>, %arg2: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4.200000e+01 : f32} : () -> f32
    %1 = "llvm.mlir.constant"() {value = 1.000000e+01 : f32} : () -> f32
    %2 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = false} : () -> i1
    %5 = "llvm.icmp"(%arg2, %4) {predicate = 0 : i64} : (i1, i1) -> i1
    %6 = "llvm.add"(%arg0, %3) : (i64, i64) -> i64
    %7 = "llvm.inttoptr"(%6) : (i64) -> !llvm.ptr<f32>
    %8 = "llvm.getelementptr"(%arg1, %2) : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %9 = "llvm.ptrtoint"(%8) : (!llvm.ptr<f32>) -> i64
    "llvm.cond_br"(%5)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%8, %9)[^bb3] : (!llvm.ptr<f32>, i64) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.store"(%1, %7) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.br"(%7, %6)[^bb3] : (!llvm.ptr<f32>, i64) -> ()
  ^bb3(%10: !llvm.ptr<f32>, %11: i64):  // 2 preds: ^bb1, ^bb2
    %12 = "llvm.inttoptr"(%11) : (i64) -> !llvm.ptr<f32>
    %13 = "llvm.load"(%12) : (!llvm.ptr<f32>) -> f32
    %14 = "llvm.fmul"(%13, %0) : (f32, f32) -> f32
    "llvm.store"(%14, %10) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "matching_phi", type = !llvm.func<void (i64, ptr<f32>, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: !llvm.ptr<f32>, %arg2: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4.200000e+01 : f32} : () -> f32
    %1 = "llvm.mlir.constant"() {value = 1.000000e+01 : f32} : () -> f32
    %2 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = false} : () -> i1
    %5 = "llvm.icmp"(%arg2, %4) {predicate = 0 : i64} : (i1, i1) -> i1
    %6 = "llvm.add"(%arg0, %3) : (i64, i64) -> i64
    %7 = "llvm.inttoptr"(%6) : (i64) -> !llvm.ptr<f32>
    %8 = "llvm.getelementptr"(%arg1, %2) : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %9 = "llvm.ptrtoint"(%8) : (!llvm.ptr<f32>) -> i64
    "llvm.cond_br"(%5)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%8, %6)[^bb3] : (!llvm.ptr<f32>, i64) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.store"(%1, %7) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.br"(%7, %9)[^bb3] : (!llvm.ptr<f32>, i64) -> ()
  ^bb3(%10: !llvm.ptr<f32>, %11: i64):  // 2 preds: ^bb1, ^bb2
    %12 = "llvm.inttoptr"(%11) : (i64) -> !llvm.ptr<f32>
    %13 = "llvm.load"(%12) : (!llvm.ptr<f32>) -> f32
    %14 = "llvm.fmul"(%13, %0) : (f32, f32) -> f32
    "llvm.store"(%14, %10) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "no_matching_phi", type = !llvm.func<void (i64, ptr<f32>, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
