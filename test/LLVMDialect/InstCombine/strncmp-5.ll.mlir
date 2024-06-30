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
  }) {constant, linkage = 10 : i64, sym_name = "d9123_12", type = !llvm.array<7 x i8>, value = "9123\0012"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "e9123_34", type = !llvm.array<7 x i8>, value = "9123\0034"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strncmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %3 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %4 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %5 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %6 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %7 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %8 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %9 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %10 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %11 = "llvm.mlir.addressof"() {global_name = @b01230123} : () -> !llvm.ptr<array<8 x i8>>
    %12 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %13 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %14 = "llvm.getelementptr"(%13, %12, %12) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %15 = "llvm.getelementptr"(%11, %12, %12) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %16 = "llvm.getelementptr"(%10, %12, %9) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %17 = "llvm.getelementptr"(%8, %12, %7) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %18 = "llvm.getelementptr"(%6, %12, %5) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %19 = "llvm.getelementptr"(%4, %12, %3) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %20 = "llvm.getelementptr"(%2, %12, %1) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %21 = "llvm.call"(%14, %15, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %22 = "llvm.getelementptr"(%arg0, %12) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%21, %22) : (i32, !llvm.ptr<i32>) -> ()
    %23 = "llvm.call"(%14, %16, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %24 = "llvm.getelementptr"(%arg0, %9) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%23, %24) : (i32, !llvm.ptr<i32>) -> ()
    %25 = "llvm.call"(%14, %17, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %26 = "llvm.getelementptr"(%arg0, %7) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%25, %26) : (i32, !llvm.ptr<i32>) -> ()
    %27 = "llvm.call"(%14, %18, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %28 = "llvm.getelementptr"(%arg0, %5) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%27, %28) : (i32, !llvm.ptr<i32>) -> ()
    %29 = "llvm.call"(%14, %19, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %30 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%29, %30) : (i32, !llvm.ptr<i32>) -> ()
    %31 = "llvm.call"(%14, %20, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %32 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%31, %32) : (i32, !llvm.ptr<i32>) -> ()
    %33 = "llvm.call"(%20, %14, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %34 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%33, %34) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strncmp_a_b_n", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<8 x i8>>
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.getelementptr"(%0, %1, %1) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%3, %4, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %6 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%5, %6) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "call_strncmp_a_ax_n", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
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
    %20 = "llvm.call"(%13, %14, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %21 = "llvm.getelementptr"(%arg0, %11) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%20, %21) : (i32, !llvm.ptr<i32>) -> ()
    %22 = "llvm.call"(%13, %15, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %23 = "llvm.getelementptr"(%arg0, %8) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%22, %23) : (i32, !llvm.ptr<i32>) -> ()
    %24 = "llvm.call"(%13, %16, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %25 = "llvm.getelementptr"(%arg0, %6) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%24, %25) : (i32, !llvm.ptr<i32>) -> ()
    %26 = "llvm.call"(%13, %17, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %27 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%26, %27) : (i32, !llvm.ptr<i32>) -> ()
    %28 = "llvm.call"(%13, %18, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %29 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%28, %29) : (i32, !llvm.ptr<i32>) -> ()
    %30 = "llvm.call"(%13, %18, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %31 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%30, %31) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strncmp_a_c_n", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @d9123_12} : () -> !llvm.ptr<array<7 x i8>>
    %2 = "llvm.mlir.addressof"() {global_name = @d9123_12} : () -> !llvm.ptr<array<7 x i8>>
    %3 = "llvm.mlir.addressof"() {global_name = @d9123_12} : () -> !llvm.ptr<array<7 x i8>>
    %4 = "llvm.mlir.addressof"() {global_name = @d9123_12} : () -> !llvm.ptr<array<7 x i8>>
    %5 = "llvm.mlir.addressof"() {global_name = @d9123_12} : () -> !llvm.ptr<array<7 x i8>>
    %6 = "llvm.mlir.addressof"() {global_name = @d9123_12} : () -> !llvm.ptr<array<7 x i8>>
    %7 = "llvm.mlir.addressof"() {global_name = @d9123_12} : () -> !llvm.ptr<array<7 x i8>>
    %8 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %9 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %10 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %11 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %12 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %13 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %14 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %15 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %16 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %17 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %18 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %19 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %20 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %21 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %22 = "llvm.getelementptr"(%21, %20, %20) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %23 = "llvm.getelementptr"(%19, %20, %18) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %24 = "llvm.getelementptr"(%17, %20, %16) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %25 = "llvm.getelementptr"(%15, %20, %14) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %26 = "llvm.getelementptr"(%13, %20, %12) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %27 = "llvm.getelementptr"(%11, %20, %10) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %28 = "llvm.getelementptr"(%9, %20, %8) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %29 = "llvm.getelementptr"(%7, %20, %20) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %30 = "llvm.getelementptr"(%6, %20, %18) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %31 = "llvm.getelementptr"(%5, %20, %16) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %32 = "llvm.getelementptr"(%4, %20, %14) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %33 = "llvm.getelementptr"(%3, %20, %12) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %34 = "llvm.getelementptr"(%2, %20, %10) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %35 = "llvm.getelementptr"(%1, %20, %8) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %36 = "llvm.call"(%22, %29, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %37 = "llvm.getelementptr"(%arg0, %20) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%36, %37) : (i32, !llvm.ptr<i32>) -> ()
    %38 = "llvm.call"(%22, %30, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %39 = "llvm.getelementptr"(%arg0, %18) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%38, %39) : (i32, !llvm.ptr<i32>) -> ()
    %40 = "llvm.call"(%23, %30, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %41 = "llvm.getelementptr"(%arg0, %16) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%40, %41) : (i32, !llvm.ptr<i32>) -> ()
    %42 = "llvm.call"(%24, %31, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %43 = "llvm.getelementptr"(%arg0, %14) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%42, %43) : (i32, !llvm.ptr<i32>) -> ()
    %44 = "llvm.call"(%25, %32, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %45 = "llvm.getelementptr"(%arg0, %12) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%44, %45) : (i32, !llvm.ptr<i32>) -> ()
    %46 = "llvm.call"(%26, %33, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %47 = "llvm.getelementptr"(%arg0, %12) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%46, %47) : (i32, !llvm.ptr<i32>) -> ()
    %48 = "llvm.call"(%33, %26, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %49 = "llvm.getelementptr"(%arg0, %10) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%48, %49) : (i32, !llvm.ptr<i32>) -> ()
    %50 = "llvm.call"(%27, %34, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %51 = "llvm.getelementptr"(%arg0, %8) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%50, %51) : (i32, !llvm.ptr<i32>) -> ()
    %52 = "llvm.call"(%28, %35, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %53 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%52, %53) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strncmp_a_d_n", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @d9123_12} : () -> !llvm.ptr<array<7 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @a01230123} : () -> !llvm.ptr<array<8 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %2) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %6 = "llvm.or"(%arg1, %0) : (i64, i64) -> i64
    %7 = "llvm.call"(%4, %5, %6) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %8 = "llvm.getelementptr"(%arg0, %2) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%7, %8) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strncmp_a_d_nz", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @e9123_34} : () -> !llvm.ptr<array<7 x i8>>
    %3 = "llvm.mlir.addressof"() {global_name = @e9123_34} : () -> !llvm.ptr<array<7 x i8>>
    %4 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %5 = "llvm.mlir.addressof"() {global_name = @d9123_12} : () -> !llvm.ptr<array<7 x i8>>
    %6 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %7 = "llvm.mlir.addressof"() {global_name = @d9123_12} : () -> !llvm.ptr<array<7 x i8>>
    %8 = "llvm.getelementptr"(%7, %6, %6) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %9 = "llvm.getelementptr"(%5, %6, %4) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %10 = "llvm.getelementptr"(%3, %6, %6) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %11 = "llvm.getelementptr"(%2, %6, %4) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %12 = "llvm.call"(%8, %10, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %13 = "llvm.getelementptr"(%arg0, %6) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%12, %13) : (i32, !llvm.ptr<i32>) -> ()
    %14 = "llvm.call"(%8, %11, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %15 = "llvm.getelementptr"(%arg0, %4) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%14, %15) : (i32, !llvm.ptr<i32>) -> ()
    %16 = "llvm.call"(%9, %10, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %17 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%16, %17) : (i32, !llvm.ptr<i32>) -> ()
    %18 = "llvm.call"(%9, %11, %arg1) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %19 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    "llvm.store"(%18, %19) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strncmp_d_e_n", type = !llvm.func<void (ptr<i32>, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
