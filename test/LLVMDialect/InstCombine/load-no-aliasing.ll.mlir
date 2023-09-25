"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<f32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %1 = "llvm.sitofp"(%0) : (i32) -> f32
    "llvm.store"(%1, %arg1) : (f32, !llvm.ptr<f32>) -> ()
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_store_load_combine", type = !llvm.func<i32 (ptr<i32>, ptr<f32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
