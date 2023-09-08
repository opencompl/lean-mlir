"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "wyhash64_x", type = i64, value = 0 : i64} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1946526487930394057 : i128} : () -> i128
    %1 = "llvm.mlir.constant"() {value = 64 : i128} : () -> i128
    %2 = "llvm.mlir.constant"() {value = 11795372955171141389 : i128} : () -> i128
    %3 = "llvm.mlir.addressof"() {global_name = @wyhash64_x} : () -> !llvm.ptr<i64>
    %4 = "llvm.mlir.constant"() {value = 6971258582664805397 : i64} : () -> i64
    %5 = "llvm.mlir.addressof"() {global_name = @wyhash64_x} : () -> !llvm.ptr<i64>
    %6 = "llvm.load"(%5) : (!llvm.ptr<i64>) -> i64
    %7 = "llvm.add"(%6, %4) : (i64, i64) -> i64
    "llvm.store"(%7, %3) : (i64, !llvm.ptr<i64>) -> ()
    %8 = "llvm.zext"(%7) : (i64) -> i128
    %9 = "llvm.mul"(%8, %2) : (i128, i128) -> i128
    %10 = "llvm.lshr"(%9, %1) : (i128, i128) -> i128
    %11 = "llvm.xor"(%10, %9) : (i128, i128) -> i128
    %12 = "llvm.trunc"(%11) : (i128) -> i64
    %13 = "llvm.zext"(%12) : (i64) -> i128
    %14 = "llvm.mul"(%13, %0) : (i128, i128) -> i128
    %15 = "llvm.lshr"(%14, %1) : (i128, i128) -> i128
    %16 = "llvm.xor"(%15, %14) : (i128, i128) -> i128
    %17 = "llvm.trunc"(%16) : (i128) -> i64
    "llvm.return"(%17) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "_Z8wyhash64v", type = !llvm.func<i64 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
