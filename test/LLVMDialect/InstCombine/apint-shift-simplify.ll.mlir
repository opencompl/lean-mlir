"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i41, %arg1: i41, %arg2: i41):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i41, i41) -> i41
    %1 = "llvm.shl"(%arg1, %arg2) : (i41, i41) -> i41
    %2 = "llvm.and"(%0, %1) : (i41, i41) -> i41
    "llvm.return"(%2) : (i41) -> ()
  }) {linkage = 10 : i64, sym_name = "test0", type = !llvm.func<i41 (i41, i41, i41)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i57, %arg1: i57, %arg2: i57):  // no predecessors
    %0 = "llvm.lshr"(%arg0, %arg2) : (i57, i57) -> i57
    %1 = "llvm.lshr"(%arg1, %arg2) : (i57, i57) -> i57
    %2 = "llvm.or"(%0, %1) : (i57, i57) -> i57
    "llvm.return"(%2) : (i57) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i57 (i57, i57, i57)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i49, %arg1: i49, %arg2: i49):  // no predecessors
    %0 = "llvm.ashr"(%arg0, %arg2) : (i49, i49) -> i49
    %1 = "llvm.ashr"(%arg1, %arg2) : (i49, i49) -> i49
    %2 = "llvm.xor"(%0, %1) : (i49, i49) -> i49
    "llvm.return"(%2) : (i49) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i49 (i49, i49, i49)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
