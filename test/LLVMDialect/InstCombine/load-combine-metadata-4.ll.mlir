"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i32>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: !llvm.ptr<ptr<i32>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32>
    "llvm.store"(%0, %1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%0, %2) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_load_combine_metadata", type = !llvm.func<void (ptr<ptr<i32>>, ptr<ptr<i32>>, ptr<ptr<i32>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
