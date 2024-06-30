"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i32>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.store"(%0, %1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%0, %2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "combine_metadata_dominance1", type = !llvm.func<void (ptr<ptr<i32>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<i32 (ptr<i32>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i32>>, %arg1: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.cond_br"(%arg1)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.store"(%0, %1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%0, %2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "combine_metadata_dominance2", type = !llvm.func<void (ptr<ptr<i32>>, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
