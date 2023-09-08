"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
