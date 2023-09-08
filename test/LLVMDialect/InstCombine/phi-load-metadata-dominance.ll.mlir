"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "baz", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: !llvm.ptr<ptr<i32>>, %arg2: !llvm.ptr<ptr<i32>>):  // no predecessors
    "llvm.cond_br"(%arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.call"() {callee = @bar, fastmathFlags = #llvm.fastmath<>} : () -> ()
    %0 = "llvm.load"(%arg1) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.br"(%0)[^bb3] : (!llvm.ptr<i32>) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.call"() {callee = @baz, fastmathFlags = #llvm.fastmath<>} : () -> ()
    %1 = "llvm.load"(%arg2) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.br"(%1)[^bb3] : (!llvm.ptr<i32>) -> ()
  ^bb3(%2: !llvm.ptr<i32>):  // 2 preds: ^bb1, ^bb2
    "llvm.return"(%2) : (!llvm.ptr<i32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_combine_metadata_dominance", type = !llvm.func<ptr<i32> (i1, ptr<ptr<i32>>, ptr<ptr<i32>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
