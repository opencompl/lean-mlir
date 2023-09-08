"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use32", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use64", type = !llvm.func<void (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 32 : i32} : () -> i32
    %3 = "llvm.sub"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.lshr"(%arg0, %3) : (i32, i32) -> i32
    %5 = "llvm.sub"(%arg1, %1) : (i32, i32) -> i32
    %6 = "llvm.lshr"(%4, %5) : (i32, i32) -> i32
    "llvm.call"(%3) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%4) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%5) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%6) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %7 = "llvm.icmp"(%6, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%7) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "highest_bit_test_via_lshr", type = !llvm.func<i1 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 64 : i32} : () -> i32
    %3 = "llvm.sub"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.zext"(%3) : (i32) -> i64
    %5 = "llvm.lshr"(%arg0, %4) : (i64, i64) -> i64
    %6 = "llvm.trunc"(%5) : (i64) -> i32
    %7 = "llvm.sub"(%arg1, %1) : (i32, i32) -> i32
    %8 = "llvm.lshr"(%6, %7) : (i32, i32) -> i32
    "llvm.call"(%3) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%4) {callee = @use64, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.call"(%5) {callee = @use64, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.call"(%6) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%7) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%8) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %9 = "llvm.icmp"(%8, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "highest_bit_test_via_lshr_with_truncation", type = !llvm.func<i1 (i64, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 32 : i32} : () -> i32
    %3 = "llvm.sub"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.ashr"(%arg0, %3) : (i32, i32) -> i32
    %5 = "llvm.sub"(%arg1, %1) : (i32, i32) -> i32
    %6 = "llvm.ashr"(%4, %5) : (i32, i32) -> i32
    "llvm.call"(%3) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%4) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%5) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%6) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %7 = "llvm.icmp"(%6, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%7) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "highest_bit_test_via_ashr", type = !llvm.func<i1 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 64 : i32} : () -> i32
    %3 = "llvm.sub"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.zext"(%3) : (i32) -> i64
    %5 = "llvm.ashr"(%arg0, %4) : (i64, i64) -> i64
    %6 = "llvm.trunc"(%5) : (i64) -> i32
    %7 = "llvm.sub"(%arg1, %1) : (i32, i32) -> i32
    %8 = "llvm.ashr"(%6, %7) : (i32, i32) -> i32
    "llvm.call"(%3) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%4) {callee = @use64, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.call"(%5) {callee = @use64, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.call"(%6) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%7) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%8) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %9 = "llvm.icmp"(%8, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "highest_bit_test_via_ashr_with_truncation", type = !llvm.func<i1 (i64, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 32 : i32} : () -> i32
    %3 = "llvm.sub"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.lshr"(%arg0, %3) : (i32, i32) -> i32
    %5 = "llvm.sub"(%arg1, %1) : (i32, i32) -> i32
    %6 = "llvm.ashr"(%4, %5) : (i32, i32) -> i32
    "llvm.call"(%3) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%4) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%5) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%6) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %7 = "llvm.icmp"(%6, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%7) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "highest_bit_test_via_lshr_ashr", type = !llvm.func<i1 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 64 : i32} : () -> i32
    %3 = "llvm.sub"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.zext"(%3) : (i32) -> i64
    %5 = "llvm.lshr"(%arg0, %4) : (i64, i64) -> i64
    %6 = "llvm.trunc"(%5) : (i64) -> i32
    %7 = "llvm.sub"(%arg1, %1) : (i32, i32) -> i32
    %8 = "llvm.ashr"(%6, %7) : (i32, i32) -> i32
    "llvm.call"(%3) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%4) {callee = @use64, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.call"(%5) {callee = @use64, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.call"(%6) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%7) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%8) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %9 = "llvm.icmp"(%8, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "highest_bit_test_via_lshr_ashe_with_truncation", type = !llvm.func<i1 (i64, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 32 : i32} : () -> i32
    %3 = "llvm.sub"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.ashr"(%arg0, %3) : (i32, i32) -> i32
    %5 = "llvm.sub"(%arg1, %1) : (i32, i32) -> i32
    %6 = "llvm.lshr"(%4, %5) : (i32, i32) -> i32
    "llvm.call"(%3) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%4) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%5) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%6) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %7 = "llvm.icmp"(%6, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%7) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "highest_bit_test_via_ashr_lshr", type = !llvm.func<i1 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 64 : i32} : () -> i32
    %3 = "llvm.sub"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.zext"(%3) : (i32) -> i64
    %5 = "llvm.ashr"(%arg0, %4) : (i64, i64) -> i64
    %6 = "llvm.trunc"(%5) : (i64) -> i32
    %7 = "llvm.sub"(%arg1, %1) : (i32, i32) -> i32
    %8 = "llvm.lshr"(%6, %7) : (i32, i32) -> i32
    "llvm.call"(%3) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%4) {callee = @use64, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.call"(%5) {callee = @use64, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.call"(%6) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%7) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.call"(%8) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %9 = "llvm.icmp"(%8, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "highest_bit_test_via_ashr_lshr_with_truncation", type = !llvm.func<i1 (i64, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.icmp"(%2, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "unsigned_sign_bit_extract", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    "llvm.call"(%2) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %3 = "llvm.icmp"(%2, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "unsigned_sign_bit_extract_extrause", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    "llvm.call"(%2) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %3 = "llvm.icmp"(%2, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "unsigned_sign_bit_extract_extrause__ispositive", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.icmp"(%2, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "signed_sign_bit_extract", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    "llvm.call"(%2) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %3 = "llvm.icmp"(%2, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "signed_sign_bit_extract_extrause", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 63 : i64} : () -> i64
    %2 = "llvm.lshr"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.trunc"(%2) : (i64) -> i32
    %4 = "llvm.icmp"(%3, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "unsigned_sign_bit_extract_with_trunc", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 63 : i64} : () -> i64
    %2 = "llvm.lshr"(%arg0, %1) : (i64, i64) -> i64
    "llvm.call"(%2) {callee = @use64, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    %3 = "llvm.trunc"(%2) : (i64) -> i32
    "llvm.call"(%3) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %4 = "llvm.icmp"(%3, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "unsigned_sign_bit_extract_with_trunc_extrause", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 63 : i64} : () -> i64
    %2 = "llvm.ashr"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.trunc"(%2) : (i64) -> i32
    %4 = "llvm.icmp"(%3, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "signed_sign_bit_extract_trunc", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 63 : i64} : () -> i64
    %2 = "llvm.ashr"(%arg0, %1) : (i64, i64) -> i64
    "llvm.call"(%2) {callee = @use64, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    %3 = "llvm.trunc"(%2) : (i64) -> i32
    "llvm.call"(%3) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %4 = "llvm.icmp"(%3, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "signed_sign_bit_extract_trunc_extrause", type = !llvm.func<i1 (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
