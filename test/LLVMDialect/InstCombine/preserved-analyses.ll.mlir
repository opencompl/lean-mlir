"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.add"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.add"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
