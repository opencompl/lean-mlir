"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = -117 : i8} : () -> i8
    %2 = "llvm.or"(%arg1, %1) : (i8, i8) -> i8
    %3 = "llvm.add"(%2, %0) : (i8, i8) -> i8
    "llvm.store"(%3, %arg0) : (i8, !llvm.ptr<i8>) -> ()
    %4 = "llvm.icmp"(%2, %3) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<i1 (ptr<i8>, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
