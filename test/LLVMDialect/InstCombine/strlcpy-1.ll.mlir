"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "s4", type = !llvm.array<5 x i8>, value = "1234\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a5", type = !llvm.array<5 x i8>, value = "12345"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strlcpy", type = !llvm.func<i64 (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sink", type = !llvm.func<void (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %5 = "llvm.mlir.addressof"() {global_name = @s4} : () -> !llvm.ptr<array<5 x i8>>
    %6 = "llvm.getelementptr"(%5, %4, %3) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%arg0, %6, %2) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %7) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %8 = "llvm.call"(%arg0, %6, %1) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %8) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %9 = "llvm.call"(%arg0, %6, %0) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %9) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strlcpy_s0", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %6 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %7 = "llvm.mlir.addressof"() {global_name = @s4} : () -> !llvm.ptr<array<5 x i8>>
    %8 = "llvm.getelementptr"(%7, %6, %5) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %9 = "llvm.call"(%arg0, %8, %4) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %9) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %10 = "llvm.call"(%arg0, %8, %3) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %10) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %11 = "llvm.call"(%arg0, %8, %2) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %11) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %12 = "llvm.call"(%arg0, %8, %1) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %12) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %13 = "llvm.call"(%arg0, %8, %0) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %13) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strlcpy_s1", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %6 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %7 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %8 = "llvm.mlir.addressof"() {global_name = @s4} : () -> !llvm.ptr<array<5 x i8>>
    %9 = "llvm.getelementptr"(%8, %7, %7) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %10 = "llvm.call"(%arg0, %9, %6) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %10) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %11 = "llvm.call"(%arg0, %9, %5) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %11) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %12 = "llvm.call"(%arg0, %9, %4) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %12) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %13 = "llvm.call"(%arg0, %9, %3) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %13) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %14 = "llvm.call"(%arg0, %9, %2) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %14) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %15 = "llvm.call"(%arg0, %9, %1) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %15) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %16 = "llvm.call"(%arg0, %9, %1) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %16) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %17 = "llvm.call"(%arg0, %9, %0) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %17) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strlcpy_s5", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64):  // no predecessors
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %3 = "llvm.call"(%arg0, %arg1, %2) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %3) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %4 = "llvm.call"(%arg0, %arg1, %1) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %4) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %5 = "llvm.call"(%0, %arg1, %1) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %5) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strlcpy_s_0", type = !llvm.func<void (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @s4} : () -> !llvm.ptr<array<5 x i8>>
    %1 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @s4} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %5 = "llvm.mlir.addressof"() {global_name = @s4} : () -> !llvm.ptr<array<5 x i8>>
    %6 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %7 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %8 = "llvm.call"(%arg0, %arg1, %7) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %8) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %9 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %9) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %10 = "llvm.or"(%arg2, %6) : (i64, i64) -> i64
    %11 = "llvm.call"(%arg0, %arg1, %10) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %11) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %12 = "llvm.getelementptr"(%5, %4, %3) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %13 = "llvm.call"(%arg0, %12, %arg2) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %13) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %14 = "llvm.getelementptr"(%2, %4, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %15 = "llvm.call"(%arg0, %14, %arg2) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %15) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %16 = "llvm.getelementptr"(%0, %4, %4) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %17 = "llvm.call"(%arg0, %16, %arg2) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %17) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "call_strlcpy_s0_n", type = !llvm.func<void (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %6 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %7 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %8 = "llvm.getelementptr"(%7, %6, %6) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %9 = "llvm.call"(%arg0, %8, %5) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %9) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %10 = "llvm.call"(%arg0, %8, %4) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %10) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %11 = "llvm.call"(%arg0, %8, %3) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %11) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %12 = "llvm.call"(%arg0, %8, %2) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %12) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %13 = "llvm.call"(%arg0, %8, %1) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %13) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    %14 = "llvm.call"(%arg0, %8, %0) {callee = @strlcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    "llvm.call"(%arg0, %14) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strlcpy_a5", type = !llvm.func<void (ptr<i8>, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
