"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "ia16a", type = !llvm.array<4 x i16>, value = dense<[24930, 25444, 25958, 26472]> : tensor<4xi16>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "i8a", type = !llvm.array<8 x i8>, value = "abcdefgg"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memcmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %6 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %7 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %8 = "llvm.mlir.addressof"() {global_name = @i8a} : () -> !llvm.ptr<array<8 x i8>>
    %9 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %10 = "llvm.mlir.addressof"() {global_name = @ia16a} : () -> !llvm.ptr<array<4 x i16>>
    %11 = "llvm.getelementptr"(%10, %9, %9) : (!llvm.ptr<array<4 x i16>>, i64, i64) -> !llvm.ptr<i16>
    %12 = "llvm.bitcast"(%11) : (!llvm.ptr<i16>) -> !llvm.ptr<i8>
    %13 = "llvm.getelementptr"(%8, %9, %9) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %14 = "llvm.call"(%12, %13, %9) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %15 = "llvm.getelementptr"(%arg0, %9) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%14, %15) : (i32, !llvm.ptr<i32>) -> ()
    %16 = "llvm.call"(%12, %13, %7) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %17 = "llvm.getelementptr"(%arg0, %7) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%16, %17) : (i32, !llvm.ptr<i32>) -> ()
    %18 = "llvm.call"(%12, %13, %6) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %19 = "llvm.getelementptr"(%arg0, %6) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%18, %19) : (i32, !llvm.ptr<i32>) -> ()
    %20 = "llvm.call"(%12, %13, %5) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %21 = "llvm.getelementptr"(%arg0, %5) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%20, %21) : (i32, !llvm.ptr<i32>) -> ()
    %22 = "llvm.call"(%12, %13, %4) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %23 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%22, %23) : (i32, !llvm.ptr<i32>) -> ()
    %24 = "llvm.call"(%12, %13, %3) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %25 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%24, %25) : (i32, !llvm.ptr<i32>) -> ()
    %26 = "llvm.call"(%12, %13, %2) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %27 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%26, %27) : (i32, !llvm.ptr<i32>) -> ()
    %28 = "llvm.call"(%12, %13, %1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %29 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%28, %29) : (i32, !llvm.ptr<i32>) -> ()
    %30 = "llvm.call"(%12, %13, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %31 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%30, %31) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memcmp_ia16a_i8a", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %5 = "llvm.mlir.addressof"() {global_name = @i8a} : () -> !llvm.ptr<array<8 x i8>>
    %6 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %7 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %8 = "llvm.mlir.addressof"() {global_name = @ia16a} : () -> !llvm.ptr<array<4 x i16>>
    %9 = "llvm.getelementptr"(%8, %7, %6) : (!llvm.ptr<array<4 x i16>>, i64, i64) -> !llvm.ptr<i16>
    %10 = "llvm.bitcast"(%9) : (!llvm.ptr<i16>) -> !llvm.ptr<i8>
    %11 = "llvm.getelementptr"(%5, %7, %6) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %12 = "llvm.call"(%10, %11, %7) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %13 = "llvm.getelementptr"(%arg0, %7) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%12, %13) : (i32, !llvm.ptr<i32>) -> ()
    %14 = "llvm.call"(%10, %11, %6) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %15 = "llvm.getelementptr"(%arg0, %6) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%14, %15) : (i32, !llvm.ptr<i32>) -> ()
    %16 = "llvm.call"(%10, %11, %4) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %17 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%16, %17) : (i32, !llvm.ptr<i32>) -> ()
    %18 = "llvm.call"(%10, %11, %3) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %19 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%18, %19) : (i32, !llvm.ptr<i32>) -> ()
    %20 = "llvm.call"(%10, %11, %2) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %21 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%20, %21) : (i32, !llvm.ptr<i32>) -> ()
    %22 = "llvm.call"(%10, %11, %1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %23 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%22, %23) : (i32, !llvm.ptr<i32>) -> ()
    %24 = "llvm.call"(%10, %11, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %25 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%24, %25) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memcmp_ia16a_p1_i8a_p1", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
