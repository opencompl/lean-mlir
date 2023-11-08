"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "ax", type = !llvm.array<0 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "a5", type = !llvm.array<5 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "s5", type = !llvm.array<6 x i8>, value = "12345\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strnlen", type = !llvm.func<i64 (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %4 = "llvm.icmp"(%3, %0) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_ax_0_eqz", type = !llvm.func<i1 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %4 = "llvm.icmp"(%3, %0) {predicate = 8 : i64} : (i64, i64) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_ax_0_gtz", type = !llvm.func<i1 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %5 = "llvm.icmp"(%4, %1) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_ax_1_eqz", type = !llvm.func<i1 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %5 = "llvm.icmp"(%4, %0) {predicate = 6 : i64} : (i64, i64) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_ax_1_lt1", type = !llvm.func<i1 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %5 = "llvm.icmp"(%4, %1) {predicate = 1 : i64} : (i64, i64) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_ax_1_neqz", type = !llvm.func<i1 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %5 = "llvm.icmp"(%4, %1) {predicate = 8 : i64} : (i64, i64) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_ax_1_gtz", type = !llvm.func<i1 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 9 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %5 = "llvm.icmp"(%4, %1) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_ax_9_eqz", type = !llvm.func<i1 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %arg0) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %4 = "llvm.icmp"(%3, %0) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strnlen_ax_n_eqz", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %2 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %3 = "llvm.or"(%arg0, %2) : (i64, i64) -> i64
    %4 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %3) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %6 = "llvm.icmp"(%5, %0) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_ax_nz_eqz", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %2 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %3 = "llvm.or"(%arg0, %2) : (i64, i64) -> i64
    %4 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %3) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %6 = "llvm.icmp"(%5, %0) {predicate = 8 : i64} : (i64, i64) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_ax_nz_gtz", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %2 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %3 = "llvm.or"(%arg1, %2) : (i64, i64) -> i64
    %4 = "llvm.getelementptr"(%1, %0, %arg0) : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %3) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %6 = "llvm.icmp"(%5, %0) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_a5_pi_nz_eqz", type = !llvm.func<i1 (i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @s5} : () -> !llvm.ptr<array<6 x i8>>
    %2 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %3 = "llvm.or"(%arg1, %2) : (i64, i64) -> i64
    %4 = "llvm.getelementptr"(%1, %0, %arg0) : (!llvm.ptr<array<6 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %3) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %6 = "llvm.icmp"(%5, %0) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strnlen_s5_pi_nz_eqz", type = !llvm.func<i1 (i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @s5} : () -> !llvm.ptr<array<6 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %arg0) : (!llvm.ptr<array<6 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %arg1) {callee = @strnlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> i64
    %4 = "llvm.icmp"(%3, %0) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strnlen_s5_pi_n_eqz", type = !llvm.func<i1 (i64, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
