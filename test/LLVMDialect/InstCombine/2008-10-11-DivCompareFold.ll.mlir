"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 65536 : i32} : () -> i32
    %2 = "llvm.sdiv"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "x", type = !llvm.func<i1 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
