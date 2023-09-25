"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.call"(%arg0) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %2 = "llvm.call"(%1, %0) {callee = @llvm.ctlz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "ctlz_true_bitreverse", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.call"(%arg0) {callee = @llvm.bitreverse.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>) -> vector<2xi64>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.ctlz.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>, i1) -> vector<2xi64>
    "llvm.return"(%2) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "ctlz_true_bitreverse_vec", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.call"(%arg0) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %2 = "llvm.call"(%1, %0) {callee = @llvm.ctlz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "ctlz_false_bitreverse", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.call"(%arg0) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_true_bitreverse", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.call"(%arg0) {callee = @llvm.bitreverse.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>) -> vector<2xi64>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>, i1) -> vector<2xi64>
    "llvm.return"(%2) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_true_bitreverse_vec", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.call"(%arg0) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_false_bitreverse", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bitreverse.i32", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bitreverse.v2i64", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ctlz.i32", type = !llvm.func<i32 (i32, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.cttz.i32", type = !llvm.func<i32 (i32, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ctlz.v2i64", type = !llvm.func<vector<2xi64> (vector<2xi64>, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.cttz.v2i64", type = !llvm.func<vector<2xi64> (vector<2xi64>, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
