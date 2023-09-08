"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.cttz.i32", type = !llvm.func<i32 (i32, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.cttz.v2i64", type = !llvm.func<vector<2xi64> (vector<2xi64>, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.zext"(%arg0) : (i16) -> i32
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_zext_zero_undef", type = !llvm.func<i32 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.zext"(%arg0) : (i16) -> i32
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_zext_zero_def", type = !llvm.func<i32 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.zext"(%arg0) : (i16) -> i32
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_zext_zero_undef_extra_use", type = !llvm.func<i32 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.zext"(%arg0) : (vector<2xi32>) -> vector<2xi64>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>, i1) -> vector<2xi64>
    "llvm.return"(%2) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_zext_zero_undef_vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.zext"(%arg0) : (vector<2xi32>) -> vector<2xi64>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>, i1) -> vector<2xi64>
    "llvm.return"(%2) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_zext_zero_def_vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.sext"(%arg0) : (i16) -> i32
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_sext_zero_undef", type = !llvm.func<i32 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.sext"(%arg0) : (i16) -> i32
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_sext_zero_def", type = !llvm.func<i32 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.sext"(%arg0) : (i16) -> i32
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_sext_zero_undef_extra_use", type = !llvm.func<i32 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.sext"(%arg0) : (vector<2xi32>) -> vector<2xi64>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>, i1) -> vector<2xi64>
    "llvm.return"(%2) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_sext_zero_undef_vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.sext"(%arg0) : (vector<2xi32>) -> vector<2xi64>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.cttz.v2i64, fastmathFlags = #llvm.fastmath<>} : (vector<2xi64>, i1) -> vector<2xi64>
    "llvm.return"(%2) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "cttz_sext_zero_def_vec", type = !llvm.func<vector<2xi64> (vector<2xi32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
