"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    %0 = "llvm.trunc"(%arg0) : (i64) -> i32
    %1 = "llvm.trunc"(%arg1) : (i64) -> i32
    %2 = "llvm.and"(%0, %1) : (i32, i32) -> i32
    %3 = "llvm.zext"(%2) : (i32) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i64 (i64, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
