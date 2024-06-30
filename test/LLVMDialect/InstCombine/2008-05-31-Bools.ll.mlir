"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i1):  // no predecessors
    %0 = "llvm.sub"(%arg0, %arg1) : (i1, i1) -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "foo1", type = !llvm.func<i1 (i1, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i1):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (i1, i1) -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "foo2", type = !llvm.func<i1 (i1, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i1):  // no predecessors
    %0 = "llvm.udiv"(%arg0, %arg1) : (i1, i1) -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "foo3", type = !llvm.func<i1 (i1, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i1):  // no predecessors
    %0 = "llvm.sdiv"(%arg0, %arg1) : (i1, i1) -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "foo4", type = !llvm.func<i1 (i1, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
