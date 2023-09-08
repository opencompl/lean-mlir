"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i61):  // no predecessors
    %0 = "llvm.trunc"(%arg0) : (i61) -> i41
    %1 = "llvm.zext"(%0) : (i41) -> i61
    "llvm.return"(%1) : (i61) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i61 (i61)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
