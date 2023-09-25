"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 6 : i8} : () -> i8
    %3 = "llvm.mlir.constant"() {value = 122 : i8} : () -> i8
    %4 = "llvm.mlir.constant"() {value = -17 : i8} : () -> i8
    %5 = "llvm.trunc"(%arg0) : (i32) -> i8
    %6 = "llvm.or"(%5, %4) : (i8, i8) -> i8
    %7 = "llvm.and"(%5, %3) : (i8, i8) -> i8
    %8 = "llvm.xor"(%7, %4) : (i8, i8) -> i8
    %9 = "llvm.shl"(%8, %2) : (i8, i8) -> i8
    %10 = "llvm.xor"(%9, %8) : (i8, i8) -> i8
    %11 = "llvm.xor"(%6, %10) : (i8, i8) -> i8
    %12 = "llvm.lshr"(%11, %1) : (i8, i8) -> i8
    %13 = "llvm.mul"(%12, %0) : (i8, i8) -> i8
    %14 = "llvm.zext"(%13) : (i8) -> i32
    "llvm.return"(%14) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = -88 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 33 : i8} : () -> i8
    %3 = "llvm.mlir.constant"() {value = -118 : i8} : () -> i8
    %4 = "llvm.mlir.constant"() {value = 84 : i8} : () -> i8
    %5 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %6 = "llvm.shl"(%arg0, %5) : (i8, i8) -> i8
    %7 = "llvm.and"(%arg1, %4) : (i8, i8) -> i8
    %8 = "llvm.and"(%arg1, %3) : (i8, i8) -> i8
    %9 = "llvm.and"(%arg1, %2) : (i8, i8) -> i8
    %10 = "llvm.sub"(%1, %7) : (i8, i8) -> i8
    %11 = "llvm.and"(%10, %4) : (i8, i8) -> i8
    %12 = "llvm.or"(%9, %11) : (i8, i8) -> i8
    %13 = "llvm.xor"(%6, %8) : (i8, i8) -> i8
    %14 = "llvm.or"(%12, %13) : (i8, i8) -> i8
    %15 = "llvm.lshr"(%13, %5) : (i8, i8) -> i8
    %16 = "llvm.shl"(%15, %0) : (i8, i8) -> i8
    %17 = "llvm.xor"(%16, %14) : (i8, i8) -> i8
    "llvm.return"(%17) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
