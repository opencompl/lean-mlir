"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<f32>) -> f32
    %1 = "llvm.bitcast"(%0) : (f32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_cast_combine_tbaa", type = !llvm.func<i32 (ptr<f32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<f32>) -> f32
    %1 = "llvm.bitcast"(%0) : (f32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_cast_combine_noalias", type = !llvm.func<i32 (ptr<f32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %1 = "llvm.bitcast"(%0) : (i32) -> f32
    "llvm.return"(%1) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_cast_combine_range", type = !llvm.func<f32 (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<f32>) -> f32
    %1 = "llvm.bitcast"(%0) : (f32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_cast_combine_invariant", type = !llvm.func<i32 (ptr<f32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<f32>) -> f32
    %1 = "llvm.bitcast"(%0) : (f32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_cast_combine_nontemporal", type = !llvm.func<i32 (ptr<f32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i32>>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_cast_combine_align", type = !llvm.func<ptr<i8> (ptr<ptr<i32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i32>>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_cast_combine_deref", type = !llvm.func<ptr<i8> (ptr<ptr<i32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i32>>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_cast_combine_deref_or_null", type = !llvm.func<ptr<i8> (ptr<ptr<i32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<i32>, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.br"(%1)[^bb1] : (i32) -> ()
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<f32>, i32) -> !llvm.ptr<f32>
    %4 = "llvm.getelementptr"(%arg1, %2) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %5 = "llvm.load"(%3) : (!llvm.ptr<f32>) -> f32
    %6 = "llvm.bitcast"(%5) : (f32) -> i32
    "llvm.store"(%6, %4) : (i32, !llvm.ptr<i32>) -> ()
    %7 = "llvm.add"(%2, %0) : (i32, i32) -> i32
    %8 = "llvm.icmp"(%7, %arg2) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%8, %7)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_cast_combine_loop", type = !llvm.func<void (ptr<f32>, ptr<i32>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<f32>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<f32>>) -> !llvm.ptr<f32>
    %2 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<ptr<f32>>, i32) -> !llvm.ptr<ptr<f32>>
    "llvm.store"(%1, %2) : (!llvm.ptr<f32>, !llvm.ptr<ptr<f32>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_cast_combine_nonnull", type = !llvm.func<void (ptr<ptr<f32>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
