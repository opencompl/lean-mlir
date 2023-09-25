"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.lshr"(%arg0, %0) : (i64, i64) -> i64
    %2 = "llvm.trunc"(%1) : (i64) -> i32
    %3 = "llvm.trunc"(%arg0) : (i64) -> i32
    %4 = "llvm.call"(%2) {callee = @llvm.bswap.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %5 = "llvm.call"(%3) {callee = @llvm.bswap.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %6 = "llvm.zext"(%4) : (i32) -> i64
    %7 = "llvm.zext"(%5) : (i32) -> i64
    %8 = "llvm.shl"(%7, %0) : (i64, i64) -> i64
    %9 = "llvm.or"(%6, %8) : (i64, i64) -> i64
    "llvm.return"(%9) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bswap32_unary_split", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<32> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.lshr"(%arg0, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %2 = "llvm.trunc"(%1) : (vector<2xi64>) -> vector<2xi32>
    %3 = "llvm.trunc"(%arg0) : (vector<2xi64>) -> vector<2xi32>
    %4 = "llvm.call"(%2) {callee = @llvm.bswap.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %5 = "llvm.call"(%3) {callee = @llvm.bswap.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %6 = "llvm.zext"(%4) : (vector<2xi32>) -> vector<2xi64>
    %7 = "llvm.zext"(%5) : (vector<2xi32>) -> vector<2xi64>
    %8 = "llvm.shl"(%7, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %9 = "llvm.or"(%6, %8) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%9) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bswap32_unary_split_vector", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.lshr"(%arg0, %0) : (i64, i64) -> i64
    %2 = "llvm.trunc"(%1) : (i64) -> i32
    %3 = "llvm.trunc"(%arg0) : (i64) -> i32
    %4 = "llvm.call"(%2) {callee = @llvm.bswap.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %5 = "llvm.call"(%3) {callee = @llvm.bswap.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %6 = "llvm.zext"(%4) : (i32) -> i64
    %7 = "llvm.zext"(%5) : (i32) -> i64
    %8 = "llvm.shl"(%6, %0) : (i64, i64) -> i64
    %9 = "llvm.or"(%7, %8) : (i64, i64) -> i64
    "llvm.return"(%9) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bswap32_unary_flip", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<32> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.lshr"(%arg0, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %2 = "llvm.trunc"(%1) : (vector<2xi64>) -> vector<2xi32>
    %3 = "llvm.trunc"(%arg0) : (vector<2xi64>) -> vector<2xi32>
    %4 = "llvm.call"(%2) {callee = @llvm.bswap.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %5 = "llvm.call"(%3) {callee = @llvm.bswap.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %6 = "llvm.zext"(%4) : (vector<2xi32>) -> vector<2xi64>
    %7 = "llvm.zext"(%5) : (vector<2xi32>) -> vector<2xi64>
    %8 = "llvm.shl"(%6, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %9 = "llvm.or"(%7, %8) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%9) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bswap32_unary_flip_vector", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.call"(%arg0) {callee = @llvm.bswap.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %2 = "llvm.call"(%arg1) {callee = @llvm.bswap.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %3 = "llvm.zext"(%1) : (i32) -> i64
    %4 = "llvm.zext"(%2) : (i32) -> i64
    %5 = "llvm.shl"(%4, %0) : (i64, i64) -> i64
    %6 = "llvm.or"(%3, %5) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bswap32_binary", type = !llvm.func<i64 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<32> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.call"(%arg0) {callee = @llvm.bswap.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.call"(%arg1) {callee = @llvm.bswap.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.zext"(%1) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.zext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %5 = "llvm.shl"(%4, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %6 = "llvm.or"(%3, %5) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%6) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bswap32_binary_vector", type = !llvm.func<vector<2xi64> (vector<2xi32>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bswap.i32", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bswap.v2i32", type = !llvm.func<vector<2xi32> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.lshr"(%arg0, %0) : (i64, i64) -> i64
    %2 = "llvm.trunc"(%1) : (i64) -> i32
    %3 = "llvm.trunc"(%arg0) : (i64) -> i32
    %4 = "llvm.call"(%2) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %5 = "llvm.call"(%3) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %6 = "llvm.zext"(%4) : (i32) -> i64
    %7 = "llvm.zext"(%5) : (i32) -> i64
    %8 = "llvm.shl"(%7, %0) : (i64, i64) -> i64
    %9 = "llvm.or"(%6, %8) : (i64, i64) -> i64
    "llvm.return"(%9) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bitreverse32_unary_split", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<32> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.lshr"(%arg0, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %2 = "llvm.trunc"(%1) : (vector<2xi64>) -> vector<2xi32>
    %3 = "llvm.trunc"(%arg0) : (vector<2xi64>) -> vector<2xi32>
    %4 = "llvm.call"(%2) {callee = @llvm.bitreverse.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %5 = "llvm.call"(%3) {callee = @llvm.bitreverse.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %6 = "llvm.zext"(%4) : (vector<2xi32>) -> vector<2xi64>
    %7 = "llvm.zext"(%5) : (vector<2xi32>) -> vector<2xi64>
    %8 = "llvm.shl"(%7, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %9 = "llvm.or"(%6, %8) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%9) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bitreverse32_unary_split_vector", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.lshr"(%arg0, %0) : (i64, i64) -> i64
    %2 = "llvm.trunc"(%1) : (i64) -> i32
    %3 = "llvm.trunc"(%arg0) : (i64) -> i32
    %4 = "llvm.call"(%2) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %5 = "llvm.call"(%3) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %6 = "llvm.zext"(%4) : (i32) -> i64
    %7 = "llvm.zext"(%5) : (i32) -> i64
    %8 = "llvm.shl"(%6, %0) : (i64, i64) -> i64
    %9 = "llvm.or"(%7, %8) : (i64, i64) -> i64
    "llvm.return"(%9) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bitreverse32_unary_flip", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<32> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.lshr"(%arg0, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %2 = "llvm.trunc"(%1) : (vector<2xi64>) -> vector<2xi32>
    %3 = "llvm.trunc"(%arg0) : (vector<2xi64>) -> vector<2xi32>
    %4 = "llvm.call"(%2) {callee = @llvm.bitreverse.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %5 = "llvm.call"(%3) {callee = @llvm.bitreverse.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %6 = "llvm.zext"(%4) : (vector<2xi32>) -> vector<2xi64>
    %7 = "llvm.zext"(%5) : (vector<2xi32>) -> vector<2xi64>
    %8 = "llvm.shl"(%6, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %9 = "llvm.or"(%7, %8) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%9) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bitreverse32_unary_flip_vector", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.call"(%arg0) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %2 = "llvm.call"(%arg1) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %3 = "llvm.zext"(%1) : (i32) -> i64
    %4 = "llvm.zext"(%2) : (i32) -> i64
    %5 = "llvm.shl"(%4, %0) : (i64, i64) -> i64
    %6 = "llvm.or"(%3, %5) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bitreverse32_binary", type = !llvm.func<i64 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<32> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.call"(%arg0) {callee = @llvm.bitreverse.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %2 = "llvm.call"(%arg1) {callee = @llvm.bitreverse.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.zext"(%1) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.zext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %5 = "llvm.shl"(%4, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %6 = "llvm.or"(%3, %5) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%6) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "concat_bitreverse32_binary_vector", type = !llvm.func<vector<2xi64> (vector<2xi32>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bitreverse.i32", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bitreverse.v2i32", type = !llvm.func<vector<2xi32> (vector<2xi32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
