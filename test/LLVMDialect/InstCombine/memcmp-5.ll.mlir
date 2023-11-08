"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "ax", type = !llvm.array<8 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a01230123", type = !llvm.array<8 x i8>, value = "01230123"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "b01230123", type = !llvm.array<8 x i8>, value = "01230123"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "c01230129", type = !llvm.array<8 x i8>, value = "01230129"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "d9123012", type = !llvm.array<7 x i8>, value = "9123012"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memcmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %2 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %4 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %5 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %6 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %7 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %8 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %9 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %10 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %11 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %12 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %13 = "llvm.getelementptr"(%12, %11, %11) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %14 = "llvm.getelementptr"(%10, %11, %11) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %15 = "llvm.getelementptr"(%9, %11, %8) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %16 = "llvm.getelementptr"(%7, %11, %6) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %17 = "llvm.getelementptr"(%5, %11, %4) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %18 = "llvm.getelementptr"(%3, %11, %2) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %19 = "llvm.getelementptr"(%1, %11, %0) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %20 = "llvm.call"(%13, %14, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %21 = "llvm.getelementptr"(%arg0, %11) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%20, %21) : (i32, !llvm.ptr<i32>) -> ()
    %22 = "llvm.call"(%13, %15, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %23 = "llvm.getelementptr"(%arg0, %8) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%22, %23) : (i32, !llvm.ptr<i32>) -> ()
    %24 = "llvm.call"(%13, %16, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %25 = "llvm.getelementptr"(%arg0, %6) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%24, %25) : (i32, !llvm.ptr<i32>) -> ()
    %26 = "llvm.call"(%13, %17, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %27 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%26, %27) : (i32, !llvm.ptr<i32>) -> ()
    %28 = "llvm.call"(%13, %18, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %29 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%28, %29) : (i32, !llvm.ptr<i32>) -> ()
    %30 = "llvm.call"(%13, %19, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %31 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%30, %31) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memcmp_a_b_n", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<8 x i8>>
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.getelementptr"(%0, %1, %1) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%3, %4, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %6 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%5, %6) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "call_memcmp_a_ax_n", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @c01230129} : () -> !llvm.ptr<array<8 x i8>>
    %2 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @c01230129} : () -> !llvm.ptr<array<8 x i8>>
    %4 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %5 = "llvm.mlir.addressof"() {global_name = @c01230129} : () -> !llvm.ptr<array<8 x i8>>
    %6 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %7 = "llvm.mlir.addressof"() {global_name = @c01230129} : () -> !llvm.ptr<array<8 x i8>>
    %8 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %9 = "llvm.mlir.addressof"() {global_name = @c01230129} : () -> !llvm.ptr<array<8 x i8>>
    %10 = "llvm.mlir.addressof"() {global_name = @c01230129} : () -> !llvm.ptr<array<8 x i8>>
    %11 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %12 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %13 = "llvm.getelementptr"(%12, %11, %11) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %14 = "llvm.getelementptr"(%10, %11, %11) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %15 = "llvm.getelementptr"(%9, %11, %8) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %16 = "llvm.getelementptr"(%7, %11, %6) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %17 = "llvm.getelementptr"(%5, %11, %4) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %18 = "llvm.getelementptr"(%3, %11, %2) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %19 = "llvm.getelementptr"(%1, %11, %0) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %20 = "llvm.call"(%13, %14, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %21 = "llvm.getelementptr"(%arg0, %11) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%20, %21) : (i32, !llvm.ptr<i32>) -> ()
    %22 = "llvm.call"(%13, %15, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %23 = "llvm.getelementptr"(%arg0, %8) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%22, %23) : (i32, !llvm.ptr<i32>) -> ()
    %24 = "llvm.call"(%13, %16, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %25 = "llvm.getelementptr"(%arg0, %6) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%24, %25) : (i32, !llvm.ptr<i32>) -> ()
    %26 = "llvm.call"(%13, %17, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %27 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%26, %27) : (i32, !llvm.ptr<i32>) -> ()
    %28 = "llvm.call"(%13, %18, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %29 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%28, %29) : (i32, !llvm.ptr<i32>) -> ()
    %30 = "llvm.call"(%13, %18, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %31 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%30, %31) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memcmp_a_c_n", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @d9123012} : () -> !llvm.ptr<array<7 x i8>>
    %3 = "llvm.mlir.addressof"() {global_name = @d9123012} : () -> !llvm.ptr<array<7 x i8>>
    %4 = "llvm.mlir.addressof"() {global_name = @d9123012} : () -> !llvm.ptr<array<7 x i8>>
    %5 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %6 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %7 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %8 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %9 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %10 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %11 = "llvm.getelementptr"(%10, %9, %9) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %12 = "llvm.getelementptr"(%8, %9, %7) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %13 = "llvm.getelementptr"(%6, %9, %5) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %14 = "llvm.getelementptr"(%4, %9, %9) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %15 = "llvm.getelementptr"(%3, %9, %7) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %16 = "llvm.getelementptr"(%2, %9, %5) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %17 = "llvm.call"(%11, %14, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %18 = "llvm.getelementptr"(%arg0, %9) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%17, %18) : (i32, !llvm.ptr<i32>) -> ()
    %19 = "llvm.call"(%11, %15, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %20 = "llvm.getelementptr"(%arg0, %7) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%19, %20) : (i32, !llvm.ptr<i32>) -> ()
    %21 = "llvm.call"(%12, %15, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %22 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%21, %22) : (i32, !llvm.ptr<i32>) -> ()
    %23 = "llvm.call"(%13, %16, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %24 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%23, %24) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memcmp_a_d_n", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @d9123012} : () -> !llvm.ptr<array<7 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %2) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %6 = "llvm.or"(%arg1, %0) : (i64, i64) -> i64
    %7 = "llvm.call"(%4, %5, %6) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %8 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%7, %8) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memcmp_a_d_nz", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
