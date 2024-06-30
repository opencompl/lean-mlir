"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %2 = "llvm.lshr"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i64, i64) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i1 (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
