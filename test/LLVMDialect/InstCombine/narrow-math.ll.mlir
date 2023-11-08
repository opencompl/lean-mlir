"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "callee", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%arg0, %0) : (i32, i32) -> i32
    %4 = "llvm.sext"(%2) : (i32) -> i64
    %5 = "llvm.sext"(%3) : (i32) -> i64
    %6 = "llvm.add"(%4, %5) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_sext_add", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.lshr"(%arg0, %0) : (i32, i32) -> i32
    %4 = "llvm.sext"(%2) : (i32) -> i64
    %5 = "llvm.zext"(%3) : (i32) -> i64
    %6 = "llvm.add"(%4, %5) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_zext_add_mismatched_exts", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i16} : () -> i16
    %2 = "llvm.ashr"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.ashr"(%arg1, %0) : (i32, i32) -> i32
    %4 = "llvm.sext"(%2) : (i16) -> i64
    %5 = "llvm.sext"(%3) : (i32) -> i64
    %6 = "llvm.add"(%4, %5) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_sext_add_mismatched_types", type = !llvm.func<i64 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%arg0, %0) : (i32, i32) -> i32
    %4 = "llvm.sext"(%2) : (i32) -> i64
    "llvm.call"(%4) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    %5 = "llvm.sext"(%3) : (i32) -> i64
    %6 = "llvm.add"(%4, %5) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_sext_add_extra_use1", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%arg0, %0) : (i32, i32) -> i32
    %4 = "llvm.sext"(%2) : (i32) -> i64
    %5 = "llvm.sext"(%3) : (i32) -> i64
    "llvm.call"(%5) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    %6 = "llvm.add"(%4, %5) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_sext_add_extra_use2", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.ashr"(%arg0, %0) : (i32, i32) -> i32
    %4 = "llvm.sext"(%2) : (i32) -> i64
    "llvm.call"(%4) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    %5 = "llvm.sext"(%3) : (i32) -> i64
    "llvm.call"(%5) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    %6 = "llvm.add"(%4, %5) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_sext_add_extra_use3", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %1 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %2 = "llvm.sext"(%0) : (i32) -> i64
    %3 = "llvm.sext"(%1) : (i32) -> i64
    %4 = "llvm.add"(%2, %3) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %1 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %2 = "llvm.add"(%0, %1) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %1 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %2 = "llvm.sext"(%0) : (i32) -> i64
    %3 = "llvm.sext"(%1) : (i32) -> i64
    %4 = "llvm.mul"(%2, %3) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %1 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %2 = "llvm.mul"(%0, %1) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1073741823 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    %4 = "llvm.add"(%3, %0) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1073741823 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    "llvm.call"(%3) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    %4 = "llvm.add"(%3, %0) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_add_constant_extra_use", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1073741823> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.sext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.add"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test5_splat", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1, 2]> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.sext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.add"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test5_vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1073741824 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    %4 = "llvm.add"(%3, %0) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-1073741824> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.sext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.add"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test6_splat", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[-1, -2]> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.sext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.add"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test6_vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[-1, 1]> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.sext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.add"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test6_vec2", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2147483647 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.zext"(%2) : (i32) -> i64
    %4 = "llvm.add"(%3, %0) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test7", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<2147483647> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.lshr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.zext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.add"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test7_splat", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[1, 2]> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.lshr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.zext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.add"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test7_vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32767 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    %4 = "llvm.mul"(%3, %0) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test8", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<32767> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<16> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.sext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.mul"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test8_splat", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[32767, 16384]> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<16> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.sext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.mul"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test8_vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[32767, -32767]> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<16> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.sext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.mul"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test8_vec2", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -32767 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    %4 = "llvm.mul"(%3, %0) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test9", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-32767> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<16> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.sext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.mul"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test9_splat", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[-32767, -10]> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<16> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.sext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.mul"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test9_vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 65535 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.zext"(%2) : (i32) -> i64
    %4 = "llvm.mul"(%3, %0) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test10", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<65535> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<16> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.lshr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.zext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.mul"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test10_splat", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[65535, 2]> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<16> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.lshr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.zext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.mul"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test10_vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %1 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %2 = "llvm.sext"(%0) : (i32) -> i64
    %3 = "llvm.sext"(%1) : (i32) -> i64
    %4 = "llvm.add"(%2, %3) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test11", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %1 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %2 = "llvm.sext"(%0) : (i32) -> i64
    %3 = "llvm.sext"(%1) : (i32) -> i64
    %4 = "llvm.mul"(%2, %3) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test12", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %1 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %2 = "llvm.sext"(%0) : (i32) -> i64
    %3 = "llvm.sext"(%1) : (i32) -> i64
    %4 = "llvm.sub"(%2, %3) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test13", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %1 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %2 = "llvm.zext"(%0) : (i32) -> i64
    %3 = "llvm.zext"(%1) : (i32) -> i64
    %4 = "llvm.sub"(%2, %3) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test14", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    %4 = "llvm.sub"(%0, %3) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test15", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<8> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.sext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.sub"(%0, %3) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test15vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4294967294 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.zext"(%2) : (i32) -> i64
    %4 = "llvm.sub"(%0, %3) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test16", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<4294967294> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.lshr"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.zext"(%2) : (vector<2xi32>) -> vector<2xi64>
    %4 = "llvm.sub"(%0, %3) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%4) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "test16vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %1 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %2 = "llvm.zext"(%0) : (i32) -> i64
    %3 = "llvm.zext"(%1) : (i32) -> i64
    %4 = "llvm.sub"(%2, %3) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test17", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2147481648 : i64} : () -> i64
    %1 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %2 = "llvm.sext"(%1) : (i32) -> i64
    %3 = "llvm.sub"(%0, %2) : (i64, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test18", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2147481648 : i64} : () -> i64
    %1 = "llvm.call"() {callee = @callee, fastmathFlags = #llvm.fastmath<>} : () -> i32
    %2 = "llvm.sext"(%1) : (i32) -> i64
    %3 = "llvm.sub"(%0, %2) : (i64, i64) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test19", type = !llvm.func<i64 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
