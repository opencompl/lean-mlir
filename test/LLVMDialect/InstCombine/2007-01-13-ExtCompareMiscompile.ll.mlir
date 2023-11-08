"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
