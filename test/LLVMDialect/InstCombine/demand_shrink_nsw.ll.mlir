"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 749011377 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -2147483648 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1533579450 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 221 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 1874836915 : i32} : () -> i32
    %6 = "llvm.mlir.constant"() {value = -784568073 : i32} : () -> i32
    %7 = "llvm.mlir.constant"() {value = 29 : i32} : () -> i32
    %8 = "llvm.mlir.constant"() {value = 223 : i32} : () -> i32
    %9 = "llvm.and"(%arg0, %8) : (i32, i32) -> i32
    %10 = "llvm.xor"(%9, %7) : (i32, i32) -> i32
    %11 = "llvm.add"(%10, %6) : (i32, i32) -> i32
    %12 = "llvm.or"(%10, %5) : (i32, i32) -> i32
    %13 = "llvm.and"(%10, %4) : (i32, i32) -> i32
    %14 = "llvm.xor"(%13, %5) : (i32, i32) -> i32
    %15 = "llvm.xor"(%12, %14) : (i32, i32) -> i32
    %16 = "llvm.shl"(%15, %3) : (i32, i32) -> i32
    %17 = "llvm.sub"(%11, %16) : (i32, i32) -> i32
    %18 = "llvm.add"(%17, %2) : (i32, i32) -> i32
    %19 = "llvm.or"(%18, %1) : (i32, i32) -> i32
    %20 = "llvm.xor"(%19, %0) : (i32, i32) -> i32
    "llvm.return"(%20) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
