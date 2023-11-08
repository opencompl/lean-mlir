"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 41 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.shl"(%1, %0) : (i32, i32) -> i32
    %3 = "llvm.icmp"(%2, %1) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i1 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
