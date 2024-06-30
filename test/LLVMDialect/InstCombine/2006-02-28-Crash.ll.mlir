"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    %3 = "llvm.zext"(%2) : (i1) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
