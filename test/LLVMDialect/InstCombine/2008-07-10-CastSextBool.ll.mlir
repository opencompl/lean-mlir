"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i1) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "PR2539_A", type = !llvm.func<i1 (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.icmp"(%arg0, %0) {predicate = 2 : i64} : (i1, i1) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "PR2539_B", type = !llvm.func<i1 (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
