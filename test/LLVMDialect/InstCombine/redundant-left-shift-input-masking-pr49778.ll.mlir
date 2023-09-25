"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i1) -> i32
    %2 = "llvm.shl"(%0, %1) : (i32, i32) -> i32
    %3 = "llvm.xor"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.and"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.shl"(%4, %1) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "src", type = !llvm.func<i32 (i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
