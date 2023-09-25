"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.icmp"(%arg0, %0) {predicate = 6 : i64} : (i1, i1) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i1 (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
