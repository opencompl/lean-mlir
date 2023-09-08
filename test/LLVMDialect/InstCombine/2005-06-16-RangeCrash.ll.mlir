"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -2147483648 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.sdiv"(%1, %0) : (i32, i32) -> i32
    %3 = "llvm.icmp"(%2, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i1 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
