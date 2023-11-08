"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 17 : i32} : () -> i32
    %1 = "llvm.sext"(%arg0) : (i8) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "eq_signed_to_small_unsigned", type = !llvm.func<i1 (i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
