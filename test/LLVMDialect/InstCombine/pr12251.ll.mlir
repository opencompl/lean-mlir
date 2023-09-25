"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<i8>) -> i8
    %3 = "llvm.and"(%2, %1) : (i8, i8) -> i8
    %4 = "llvm.icmp"(%3, %0) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "_Z3fooPb", type = !llvm.func<i1 (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
