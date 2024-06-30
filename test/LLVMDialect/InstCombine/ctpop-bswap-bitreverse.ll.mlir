"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %1 = "llvm.call"(%0) {callee = @llvm.ctpop.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "ctpop_bitreverse", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.bitreverse.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>) -> vector<2xi64>
    %1 = "llvm.call"(%0) {callee = @llvm.ctpop.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%1) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "ctpop_bitreverse_vec", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.bswap.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %1 = "llvm.call"(%0) {callee = @llvm.ctpop.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "ctpop_bswap", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.bswap.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>) -> vector<2xi64>
    %1 = "llvm.call"(%0) {callee = @llvm.ctpop.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%1) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "ctpop_bswap_vec", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bitreverse.i32", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bitreverse.v2i64", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bswap.i32", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bswap.v2i64", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ctpop.i32", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ctpop.v2i64", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
