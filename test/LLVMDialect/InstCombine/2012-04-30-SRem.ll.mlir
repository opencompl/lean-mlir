"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 24 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1656690544 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %3 = "llvm.xor"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.srem"(%1, %3) : (i32, i32) -> i32
    %5 = "llvm.shl"(%4, %0) : (i32, i32) -> i32
    %6 = "llvm.ashr"(%5, %0) : (i32, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
