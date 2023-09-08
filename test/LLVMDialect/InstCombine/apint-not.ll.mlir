"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i33):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i33} : () -> i33
    %1 = "llvm.xor"(%arg0, %0) : (i33, i33) -> i33
    %2 = "llvm.xor"(%1, %0) : (i33, i33) -> i33
    "llvm.return"(%2) : (i33) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i33 (i33)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i52, %arg1: i52):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.icmp"(%arg0, %arg1) {predicate = 7 : i64} : (i52, i52) -> i1
    %2 = "llvm.xor"(%1, %0) : (i1, i1) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i1 (i52, i52)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
