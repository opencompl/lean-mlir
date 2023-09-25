"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4294967294 : i64} : () -> i64
    %2 = "llvm.or"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.trunc"(%2) : (i64) -> i32
    %4 = "llvm.srem"(%3, %0) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
