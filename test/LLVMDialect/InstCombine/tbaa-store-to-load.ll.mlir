"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    "llvm.store"(%0, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    %1 = "llvm.load"(%arg1) : (!llvm.ptr<i64>) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<i64 (ptr<i64>, ptr<i64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
