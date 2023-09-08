"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "s1", type = !llvm.array<2 x i8>, value = "\01\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "s7f", type = !llvm.array<2 x i8>, value = "\7F\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "s80", type = !llvm.array<2 x i8>, value = "\80\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "sff", type = !llvm.array<2 x i8>, value = "\FF\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "pcnt_c", type = !llvm.array<3 x i8>, value = "%c\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "pcnt_s", type = !llvm.array<3 x i8>, value = "%s\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "putchar", type = !llvm.func<i16 (i16)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "puts", type = !llvm.func<i16 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "printf", type = !llvm.func<i16 (ptr<i8>, ...)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 255 : i16} : () -> i16
    %1 = "llvm.mlir.addressof"() {global_name = @sff} : () -> !llvm.ptr<array<2 x i8>>
    %2 = "llvm.mlir.constant"() {value = 128 : i16} : () -> i16
    %3 = "llvm.mlir.addressof"() {global_name = @s80} : () -> !llvm.ptr<array<2 x i8>>
    %4 = "llvm.mlir.constant"() {value = 127 : i16} : () -> i16
    %5 = "llvm.mlir.addressof"() {global_name = @s7f} : () -> !llvm.ptr<array<2 x i8>>
    %6 = "llvm.mlir.constant"() {value = 1 : i16} : () -> i16
    %7 = "llvm.mlir.addressof"() {global_name = @s1} : () -> !llvm.ptr<array<2 x i8>>
    %8 = "llvm.mlir.addressof"() {global_name = @pcnt_s} : () -> !llvm.ptr<array<3 x i8>>
    %9 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %10 = "llvm.mlir.addressof"() {global_name = @pcnt_c} : () -> !llvm.ptr<array<3 x i8>>
    %11 = "llvm.getelementptr"(%10, %9, %9) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %12 = "llvm.getelementptr"(%8, %9, %9) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %13 = "llvm.getelementptr"(%7, %9, %9) : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %14 = "llvm.call"(%13) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i16
    %15 = "llvm.call"(%11, %6) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i16) -> i16
    %16 = "llvm.call"(%12, %13) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i16
    %17 = "llvm.getelementptr"(%5, %9, %9) : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %18 = "llvm.call"(%17) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i16
    %19 = "llvm.call"(%11, %4) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i16) -> i16
    %20 = "llvm.call"(%12, %17) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i16
    %21 = "llvm.getelementptr"(%3, %9, %9) : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %22 = "llvm.call"(%21) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i16
    %23 = "llvm.call"(%11, %2) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i16) -> i16
    %24 = "llvm.call"(%12, %21) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i16
    %25 = "llvm.getelementptr"(%1, %9, %9) : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %26 = "llvm.call"(%25) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i16
    %27 = "llvm.call"(%11, %0) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i16) -> i16
    %28 = "llvm.call"(%12, %25) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i16
    %29 = "llvm.call"(%11, %arg0) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8) -> i16
    %30 = "llvm.call"(%11, %arg1) {callee = @printf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i16) -> i16
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "xform_printf", type = !llvm.func<void (i8, i16)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
