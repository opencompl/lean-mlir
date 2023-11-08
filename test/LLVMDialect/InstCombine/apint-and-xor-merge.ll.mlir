"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i57, %arg1: i57, %arg2: i57):  // no predecessors
    %0 = "llvm.and"(%arg2, %arg0) : (i57, i57) -> i57
    %1 = "llvm.and"(%arg2, %arg1) : (i57, i57) -> i57
    %2 = "llvm.xor"(%0, %1) : (i57, i57) -> i57
    "llvm.return"(%2) : (i57) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i57 (i57, i57, i57)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i23, %arg1: i23, %arg2: i23):  // no predecessors
    %0 = "llvm.and"(%arg1, %arg0) : (i23, i23) -> i23
    %1 = "llvm.or"(%arg1, %arg0) : (i23, i23) -> i23
    %2 = "llvm.xor"(%0, %1) : (i23, i23) -> i23
    "llvm.return"(%2) : (i23) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i23 (i23, i23, i23)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
