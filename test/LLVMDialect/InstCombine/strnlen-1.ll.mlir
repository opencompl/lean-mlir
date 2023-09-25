"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "ax", type = !llvm.array<0 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "s5", type = !llvm.array<6 x i8>, value = "12345\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "s5_3", type = !llvm.array<9 x i8>, value = "12345\00xyz"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strnlen", type = !llvm.func<i64 (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%0) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "no_access_strnlen_p_n", type = !llvm.func<i64 (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%1) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "access_strnlen_p_2", type = !llvm.func<i64 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.or"(%arg1, %0) : (i64, i64) -> i64
    %2 = "llvm.call"(%arg0, %1) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "access_strnlen_p_nz", type = !llvm.func<i64 (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_ax_0", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_ax_1", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @s5} : () -> !llvm.ptr<array<6 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s5_0", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @s5} : () -> !llvm.ptr<array<6 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s5_4", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @s5} : () -> !llvm.ptr<array<6 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s5_5", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @s5} : () -> !llvm.ptr<array<6 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s5_m1", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @s5_3} : () -> !llvm.ptr<array<9 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %1) : (!llvm.ptr<array<9 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s5_3_p4_5", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @s5_3} : () -> !llvm.ptr<array<9 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %1) : (!llvm.ptr<array<9 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s5_3_p5_5", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @s5_3} : () -> !llvm.ptr<array<9 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %1) : (!llvm.ptr<array<9 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s5_3_p6_3", type = !llvm.func<i64 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @s5_3} : () -> !llvm.ptr<array<9 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %1) : (!llvm.ptr<array<9 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strnlen_s5_3_p6_4", type = !llvm.func<i64 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
