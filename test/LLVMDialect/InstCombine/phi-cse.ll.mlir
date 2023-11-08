"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>):  // no predecessors
    "llvm.cond_br"(%arg2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg0, %arg0)[^bb3] : (i32, i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%arg1, %arg1)[^bb3] : (i32, i32) -> ()
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.store"(%0, %arg3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%1, %arg4) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test0", type = !llvm.func<void (i32, i32, i1, ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>):  // no predecessors
    "llvm.cond_br"(%arg2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg0, %arg0)[^bb3] : (i32, i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%arg1, %arg1)[^bb3] : (i32, i32) -> ()
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.store"(%0, %arg3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%1, %arg4) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<void (i32, i32, i1, ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: !llvm.ptr<i32>, %arg5: !llvm.ptr<i32>):  // no predecessors
    "llvm.cond_br"(%arg3)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg0, %arg0)[^bb3] : (i32, i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%arg1, %arg2)[^bb3] : (i32, i32) -> ()
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.store"(%0, %arg4) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%1, %arg5) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "negative_test2", type = !llvm.func<void (i32, i32, i32, i1, ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: !llvm.ptr<i32>, %arg5: !llvm.ptr<i32>):  // no predecessors
    "llvm.cond_br"(%arg3)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg0, %arg0)[^bb3] : (i32, i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%arg1, %arg2)[^bb3] : (i32, i32) -> ()
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.store"(%0, %arg4) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%1, %arg5) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "negative_test3", type = !llvm.func<void (i32, i32, i32, i1, ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>):  // no predecessors
    "llvm.cond_br"(%arg2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg0, %arg0)[^bb3] : (i32, i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%arg1, %arg1)[^bb3] : (i32, i32) -> ()
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.store"(%0, %arg3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%1, %arg4) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "negative_test4", type = !llvm.func<void (i32, i32, i1, ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>):  // no predecessors
    "llvm.cond_br"(%arg2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg0, %arg0)[^bb3] : (i32, i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%arg1, %arg1)[^bb3] : (i32, i32) -> ()
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.store"(%1, %arg4) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<void (i32, i32, i1, ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>):  // no predecessors
    "llvm.cond_br"(%arg2)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg0, %arg0)[^bb3] : (i32, i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%arg1, %arg1)[^bb3] : (i32, i32) -> ()
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.store"(%0, %arg3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<void (i32, i32, i1, ptr<i32>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr<i32>, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i16>):  // no predecessors
    "llvm.cond_br"(%arg4)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg2, %arg0, %arg0)[^bb3] : (i16, i32, i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%arg3, %arg1, %arg1)[^bb3] : (i16, i32, i32) -> ()
  ^bb3(%0: i16, %1: i32, %2: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.store"(%1, %arg5) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%2, %arg6) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%0, %arg7) : (i16, !llvm.ptr<i16>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test7", type = !llvm.func<void (i32, i32, i16, i16, i1, ptr<i32>, ptr<i32>, ptr<i16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr<i32>, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i16>):  // no predecessors
    "llvm.cond_br"(%arg4)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg0, %arg2, %arg0)[^bb3] : (i32, i16, i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%arg1, %arg3, %arg1)[^bb3] : (i32, i16, i32) -> ()
  ^bb3(%0: i32, %1: i16, %2: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.store"(%0, %arg5) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%2, %arg6) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%1, %arg7) : (i16, !llvm.ptr<i16>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test8", type = !llvm.func<void (i32, i32, i16, i16, i1, ptr<i32>, ptr<i32>, ptr<i16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr<i32>, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i16>):  // no predecessors
    "llvm.cond_br"(%arg4)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg0, %arg0, %arg2)[^bb3] : (i32, i32, i16) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%arg1, %arg1, %arg3)[^bb3] : (i32, i32, i16) -> ()
  ^bb3(%0: i32, %1: i32, %2: i16):  // 2 preds: ^bb1, ^bb2
    "llvm.store"(%0, %arg5) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%1, %arg6) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%2, %arg7) : (i16, !llvm.ptr<i16>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test9", type = !llvm.func<void (i32, i32, i16, i16, i1, ptr<i32>, ptr<i32>, ptr<i16>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
