"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 8 : i16} : () -> i16
    %3 = "llvm.mlir.constant"() {value = 71 : i16} : () -> i16
    %4 = "llvm.zext"(%arg0) : (i8) -> i16
    %5 = "llvm.mul"(%4, %3) : (i16, i16) -> i16
    %6 = "llvm.lshr"(%5, %2) : (i16, i16) -> i16
    %7 = "llvm.trunc"(%6) : (i16) -> i8
    %8 = "llvm.sub"(%arg0, %7) : (i8, i8) -> i8
    %9 = "llvm.lshr"(%8, %1) : (i8, i8) -> i8
    %10 = "llvm.add"(%7, %9) : (i8, i8) -> i8
    %11 = "llvm.lshr"(%10, %0) : (i8, i8) -> i8
    "llvm.return"(%11) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "fast_div_201", type = !llvm.func<i8 (i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
