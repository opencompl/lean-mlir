"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 65544 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i8) -> i32
    %2 = "llvm.and"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i32 (i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
