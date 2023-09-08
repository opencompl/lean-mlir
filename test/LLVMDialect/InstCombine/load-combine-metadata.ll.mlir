"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>, %arg2: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    "llvm.store"(%0, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%1, %arg2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_load_combine_metadata", type = !llvm.func<void (ptr<i32>, ptr<i32>, ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
