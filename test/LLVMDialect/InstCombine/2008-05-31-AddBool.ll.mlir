"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i1):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i1, i1) -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i1 (i1, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
