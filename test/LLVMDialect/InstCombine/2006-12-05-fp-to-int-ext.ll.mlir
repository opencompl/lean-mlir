"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: f64):  // no predecessors
    %0 = "llvm.fptoui"(%arg0) : (f64) -> i32
    %1 = "llvm.zext"(%0) : (i32) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i64 (f64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
