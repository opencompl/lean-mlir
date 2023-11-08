"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i31):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 15 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 16384 : i32} : () -> i32
    %2 = "llvm.sext"(%arg0) : (i31) -> i32
    %3 = "llvm.add"(%2, %1) : (i32, i32) -> i32
    %4 = "llvm.lshr"(%3, %0) : (i32, i32) -> i32
    %5 = "llvm.trunc"(%4) : (i32) -> i16
    "llvm.return"(%5) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i16 (i31)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
