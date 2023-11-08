"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.shl"(%1, %arg0) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %1) : (i32, i32) -> i32
    %4 = "llvm.icmp"(%3, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "PR2330", type = !llvm.func<i1 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
