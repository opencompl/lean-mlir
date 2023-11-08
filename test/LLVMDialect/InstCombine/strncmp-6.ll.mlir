"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a", type = !llvm.array<7 x i8>, value = "abcdef\7F"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "b", type = !llvm.array<7 x i8>, value = "abcdef\80"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strncmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @b} : () -> !llvm.ptr<array<7 x i8>>
    %4 = "llvm.mlir.addressof"() {global_name = @b} : () -> !llvm.ptr<array<7 x i8>>
    %5 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %6 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<array<7 x i8>>
    %7 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %8 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %9 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<array<7 x i8>>
    %10 = "llvm.getelementptr"(%9, %8, %7) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %11 = "llvm.getelementptr"(%6, %8, %5) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %12 = "llvm.getelementptr"(%4, %8, %7) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %13 = "llvm.getelementptr"(%3, %8, %5) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %14 = "llvm.call"(%10, %12, %2) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %15 = "llvm.getelementptr"(%arg0, %8) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%14, %15) : (i32, !llvm.ptr<i32>) -> ()
    %16 = "llvm.call"(%12, %10, %2) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %17 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%16, %17) : (i32, !llvm.ptr<i32>) -> ()
    %18 = "llvm.call"(%11, %13, %1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %19 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%18, %19) : (i32, !llvm.ptr<i32>) -> ()
    %20 = "llvm.call"(%13, %11, %1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %21 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%20, %21) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strncmp_cst_cst", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @b} : () -> !llvm.ptr<array<7 x i8>>
    %4 = "llvm.mlir.addressof"() {global_name = @b} : () -> !llvm.ptr<array<7 x i8>>
    %5 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %6 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<array<7 x i8>>
    %7 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %8 = "llvm.mlir.addressof"() {global_name = @a} : () -> !llvm.ptr<array<7 x i8>>
    %9 = "llvm.getelementptr"(%8, %7, %7) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %10 = "llvm.getelementptr"(%6, %7, %5) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %11 = "llvm.getelementptr"(%4, %7, %7) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %12 = "llvm.getelementptr"(%3, %7, %5) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %13 = "llvm.call"(%9, %11, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %14 = "llvm.getelementptr"(%arg0, %7) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%13, %14) : (i32, !llvm.ptr<i32>) -> ()
    %15 = "llvm.call"(%11, %9, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %16 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%15, %16) : (i32, !llvm.ptr<i32>) -> ()
    %17 = "llvm.call"(%10, %12, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %18 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%17, %18) : (i32, !llvm.ptr<i32>) -> ()
    %19 = "llvm.call"(%12, %10, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %20 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%19, %20) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strncmp_cst_var", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
