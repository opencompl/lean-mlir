"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i16):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i16) -> i32
    %1 = "llvm.sext"(%arg1) : (i16) -> i32
    %2 = "llvm.add"(%0, %1) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i64 (i16, i16)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
