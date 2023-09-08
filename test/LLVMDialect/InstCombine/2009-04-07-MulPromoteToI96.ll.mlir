"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i96, %arg1: i96):  // no predecessors
    %0 = "llvm.trunc"(%arg0) : (i96) -> i64
    %1 = "llvm.trunc"(%arg1) : (i96) -> i64
    %2 = "llvm.mul"(%0, %1) : (i64, i64) -> i64
    %3 = "llvm.zext"(%2) : (i64) -> i96
    "llvm.return"(%3) : (i96) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i96 (i96, i96)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
