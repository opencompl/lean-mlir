"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.extract.v10i32.v8i32", type = !llvm.func<vector<10xi32> (vector<8xi32>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.extract.v2i32.v4i32", type = !llvm.func<vector<2xi32> (vector<8xi32>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.extract.v3i32.v8i32", type = !llvm.func<vector<3xi32> (vector<8xi32>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.extract.v4i32.nxv4i32", type = !llvm.func<vector<4xi32> (vec<? x 4 x i32>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.extract.v4i32.v8i32", type = !llvm.func<vector<4xi32> (vector<8xi32>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.extract.v8i32.v8i32", type = !llvm.func<vector<8xi32> (vector<8xi32>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.vector.extract.v8i32.v8i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, i64) -> vector<8xi32>
    "llvm.return"(%1) : (vector<8xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "trivial_nop", type = !llvm.func<vector<8xi32> (vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.vector.extract.v2i32.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, i64) -> vector<2xi32>
    "llvm.return"(%1) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_extraction_a", type = !llvm.func<vector<2xi32> (vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.vector.extract.v2i32.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, i64) -> vector<2xi32>
    "llvm.return"(%1) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_extraction_b", type = !llvm.func<vector<2xi32> (vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.vector.extract.v2i32.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, i64) -> vector<2xi32>
    "llvm.return"(%1) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_extraction_c", type = !llvm.func<vector<2xi32> (vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.vector.extract.v2i32.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, i64) -> vector<2xi32>
    "llvm.return"(%1) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_extraction_d", type = !llvm.func<vector<2xi32> (vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.vector.extract.v4i32.v8i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, i64) -> vector<4xi32>
    "llvm.return"(%1) : (vector<4xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_extraction_e", type = !llvm.func<vector<4xi32> (vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.vector.extract.v4i32.v8i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, i64) -> vector<4xi32>
    "llvm.return"(%1) : (vector<4xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_extraction_f", type = !llvm.func<vector<4xi32> (vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.vector.extract.v3i32.v8i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, i64) -> vector<3xi32>
    "llvm.return"(%1) : (vector<3xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_extraction_g", type = !llvm.func<vector<3xi32> (vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.vector.extract.v3i32.v8i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, i64) -> vector<3xi32>
    "llvm.return"(%1) : (vector<3xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_extraction_h", type = !llvm.func<vector<3xi32> (vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<? x 4 x i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %0) {callee = @llvm.vector.extract.v4i32.nxv4i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 4 x i32>, i64) -> vector<4xi32>
    "llvm.return"(%1) : (vector<4xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "scalable_extract", type = !llvm.func<vector<4xi32> (vec<? x 4 x i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
