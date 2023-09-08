"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "sx", type = !llvm.array<0 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a3", type = !llvm.array<3 x i8>, value = "123"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "s3", type = !llvm.array<4 x i8>, value = "123\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "s5", type = !llvm.array<6 x i8>, value = "12345\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "s5_3", type = !llvm.array<10 x i8>, value = "12345\00abc\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strnlen", type = !llvm.func<i64 (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @sx} : () -> !llvm.ptr<array<0 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %arg0) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_sx_pi_0", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @sx} : () -> !llvm.ptr<array<0 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %arg0) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %arg1) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strnlen_sx_pi_n", type = !llvm.func<i64 (i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a3} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %arg0) : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strnlen_a3_pi_2", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a3} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %arg0) : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strnlen_a3_pi_3", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @s3} : () -> !llvm.ptr<array<4 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %arg0) : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s3_pi_0", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @s5} : () -> !llvm.ptr<array<6 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strnlen_s5_pi_0", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @s5_3} : () -> !llvm.ptr<array<10 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %arg0) : (!llvm.ptr<array<10 x i8>>, i32, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s5_3_pi_0", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @s5_3} : () -> !llvm.ptr<array<10 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %arg0) : (!llvm.ptr<array<10 x i8>>, i32, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %arg1) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strnlen_s5_3_pi_n", type = !llvm.func<i64 (i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @a3} : () -> !llvm.ptr<array<3 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %arg0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_a3_n", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @s3} : () -> !llvm.ptr<array<4 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %arg0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s3_n", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a3} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %arg0) : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_a3_pi_2", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @s3} : () -> !llvm.ptr<array<4 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %arg0) : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s3_pi_2", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @s3} : () -> !llvm.ptr<array<4 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %arg0) : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s3_pi_3", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @s3} : () -> !llvm.ptr<array<4 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %arg0) : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %arg1) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s3_pi_n", type = !llvm.func<i64 (i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @s5_3} : () -> !llvm.ptr<array<10 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %arg0) : (!llvm.ptr<array<10 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strnlen_s5_3_pi_2", type = !llvm.func<i64 (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
