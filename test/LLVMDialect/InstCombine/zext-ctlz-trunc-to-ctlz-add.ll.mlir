"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ctlz.i3", type = !llvm.func<i3 (i3, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ctlz.i32", type = !llvm.func<i32 (i32, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ctlz.i34", type = !llvm.func<i34 (i34, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ctlz.v2i33", type = !llvm.func<vector<2xi33> (vector<2xi33>, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ctlz.v2i32", type = !llvm.func<vector<2xi32> (vector<2xi32>, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ctlz.nxv2i64", type = !llvm.func<vec<? x 2 x i64> (vec<? x 2 x i64>, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.ctlz.nxv2i63", type = !llvm.func<vec<? x 2 x i63> (vec<? x 2 x i63>, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use1", type = !llvm.func<void (vec<? x 2 x i63>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.zext"(%arg0) : (i16) -> i32
    %2 = "llvm.call"(%1, %0) {callee = @llvm.ctlz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    %3 = "llvm.trunc"(%2) : (i32) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "trunc_ctlz_zext_i16_i32", type = !llvm.func<i16 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi33>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.ctlz.v2i33, fastmathFlags = #llvm.fastmath<>} : (vector<2xi33>, i1) -> vector<2xi33>
    %3 = "llvm.trunc"(%2) : (vector<2xi33>) -> vector<2xi8>
    "llvm.return"(%3) : (vector<2xi8>) -> ()
  }) {linkage = 10 : i64, sym_name = "trunc_ctlz_zext_v2i8_v2i33", type = !llvm.func<vector<2xi8> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<? x 2 x i16>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.zext"(%arg0) : (!llvm.vec<? x 2 x i16>) -> !llvm.vec<? x 2 x i64>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.ctlz.nxv2i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 2 x i64>, i1) -> !llvm.vec<? x 2 x i64>
    %3 = "llvm.trunc"(%2) : (!llvm.vec<? x 2 x i64>) -> !llvm.vec<? x 2 x i16>
    "llvm.return"(%3) : (!llvm.vec<? x 2 x i16>) -> ()
  }) {linkage = 10 : i64, sym_name = "trunc_ctlz_zext_nxv2i16_nxv2i64", type = !llvm.func<vec<? x 2 x i16> (vec<? x 2 x i16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi17>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.zext"(%arg0) : (vector<2xi17>) -> vector<2xi32>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.ctlz.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>, i1) -> vector<2xi32>
    %3 = "llvm.trunc"(%2) : (vector<2xi32>) -> vector<2xi17>
    "llvm.call"(%2) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (vector<2xi32>) -> ()
    "llvm.return"(%3) : (vector<2xi17>) -> ()
  }) {linkage = 10 : i64, sym_name = "trunc_ctlz_zext_v2i17_v2i32_multiple_uses", type = !llvm.func<vector<2xi17> (vector<2xi17>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<? x 2 x i16>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.zext"(%arg0) : (!llvm.vec<? x 2 x i16>) -> !llvm.vec<? x 2 x i63>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.ctlz.nxv2i63, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 2 x i63>, i1) -> !llvm.vec<? x 2 x i63>
    %3 = "llvm.trunc"(%2) : (!llvm.vec<? x 2 x i63>) -> !llvm.vec<? x 2 x i16>
    "llvm.call"(%1) {callee = @use1, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 2 x i63>) -> ()
    "llvm.return"(%3) : (!llvm.vec<? x 2 x i16>) -> ()
  }) {linkage = 10 : i64, sym_name = "trunc_ctlz_zext_nxv2i16_nxv2i63_multiple_uses", type = !llvm.func<vec<? x 2 x i16> (vec<? x 2 x i16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i10):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.zext"(%arg0) : (i10) -> i32
    %2 = "llvm.call"(%1, %0) {callee = @llvm.ctlz.i32, fastmathFlags = #llvm.fastmath<>} : (i32, i1) -> i32
    %3 = "llvm.trunc"(%2) : (i32) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "trunc_ctlz_zext_i10_i32", type = !llvm.func<i16 (i10)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i3):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.zext"(%arg0) : (i3) -> i34
    %2 = "llvm.call"(%1, %0) {callee = @llvm.ctlz.i34, fastmathFlags = #llvm.fastmath<>} : (i34, i1) -> i34
    %3 = "llvm.trunc"(%2) : (i34) -> i3
    "llvm.return"(%3) : (i3) -> ()
  }) {linkage = 10 : i64, sym_name = "trunc_ctlz_zext_i3_i34", type = !llvm.func<i3 (i3)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
