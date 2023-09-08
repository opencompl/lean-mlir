"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i43):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i43} : () -> i43
    %1 = "llvm.bitcast"(%arg0) : (i43) -> i43
    %2 = "llvm.and"(%1, %0) : (i43, i43) -> i43
    %3 = "llvm.trunc"(%2) : (i43) -> i19
    "llvm.return"(%3) : (i19) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i19 (i43)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i677):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i677} : () -> i677
    %1 = "llvm.bitcast"(%arg0) : (i677) -> i677
    %2 = "llvm.and"(%1, %0) : (i677, i677) -> i677
    %3 = "llvm.trunc"(%2) : (i677) -> i73
    "llvm.return"(%3) : (i73) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i73 (i677)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
