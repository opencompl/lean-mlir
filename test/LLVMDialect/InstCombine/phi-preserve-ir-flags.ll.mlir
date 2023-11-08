"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1):  // no predecessors
    "llvm.cond_br"(%arg3)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %0 = "llvm.fsub"(%arg0, %arg1) : (f32, f32) -> f32
    "llvm.br"(%0)[^bb3] : (f32) -> ()
  ^bb2:  // pred: ^bb0
    %1 = "llvm.fsub"(%arg0, %arg2) : (f32, f32) -> f32
    "llvm.br"(%1)[^bb3] : (f32) -> ()
  ^bb3(%2: f32):  // 2 preds: ^bb1, ^bb2
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "func1", type = !llvm.func<f32 (f32, f32, f32, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1):  // no predecessors
    "llvm.cond_br"(%arg3)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %0 = "llvm.fsub"(%arg0, %arg1) : (f32, f32) -> f32
    "llvm.br"(%0)[^bb3] : (f32) -> ()
  ^bb2:  // pred: ^bb0
    %1 = "llvm.fsub"(%arg0, %arg2) : (f32, f32) -> f32
    "llvm.br"(%1)[^bb3] : (f32) -> ()
  ^bb3(%2: f32):  // 2 preds: ^bb1, ^bb2
    "llvm.return"(%2) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "func2", type = !llvm.func<f32 (f32, f32, f32, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2.000000e+00 : f32} : () -> f32
    "llvm.cond_br"(%arg3)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "llvm.fsub"(%arg0, %0) : (f32, f32) -> f32
    "llvm.br"(%1)[^bb3] : (f32) -> ()
  ^bb2:  // pred: ^bb0
    %2 = "llvm.fsub"(%arg1, %0) : (f32, f32) -> f32
    "llvm.br"(%2)[^bb3] : (f32) -> ()
  ^bb3(%3: f32):  // 2 preds: ^bb1, ^bb2
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "func3", type = !llvm.func<f32 (f32, f32, f32, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2.000000e+00 : f32} : () -> f32
    "llvm.cond_br"(%arg3)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "llvm.fsub"(%arg0, %0) : (f32, f32) -> f32
    "llvm.br"(%1)[^bb3] : (f32) -> ()
  ^bb2:  // pred: ^bb0
    %2 = "llvm.fsub"(%arg1, %0) : (f32, f32) -> f32
    "llvm.br"(%2)[^bb3] : (f32) -> ()
  ^bb3(%3: f32):  // 2 preds: ^bb1, ^bb2
    "llvm.return"(%3) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "func4", type = !llvm.func<f32 (f32, f32, f32, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
