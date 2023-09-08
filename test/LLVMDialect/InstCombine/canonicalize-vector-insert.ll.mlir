"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.insert.v8i32.v2i32", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<2xi32>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.insert.v8i32.v3i32", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<3xi32>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.insert.v8i32.v4i32", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<4xi32>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.insert.v8i32.v8i32", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<8xi32>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.insert.nxv4i32.v4i32", type = !llvm.func<vec<? x 4 x i32> (vec<? x 4 x i32>, vector<4xi32>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<8xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.v8i32.v8i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, vector<8xi32>, i64) -> vector<8xi32>
    "llvm.return"(%1) : (vector<8xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "trivial_nop", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.v8i32.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, vector<2xi32>, i64) -> vector<8xi32>
    "llvm.return"(%1) : (vector<8xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_insertion_a", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.v8i32.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, vector<2xi32>, i64) -> vector<8xi32>
    "llvm.return"(%1) : (vector<8xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_insertion_b", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.v8i32.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, vector<2xi32>, i64) -> vector<8xi32>
    "llvm.return"(%1) : (vector<8xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_insertion_c", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.v8i32.v2i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, vector<2xi32>, i64) -> vector<8xi32>
    "llvm.return"(%1) : (vector<8xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_insertion_d", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<4xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.v8i32.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, vector<4xi32>, i64) -> vector<8xi32>
    "llvm.return"(%1) : (vector<8xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_insertion_e", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<4xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<4xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.v8i32.v4i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, vector<4xi32>, i64) -> vector<8xi32>
    "llvm.return"(%1) : (vector<8xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_insertion_f", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<4xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<3xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.v8i32.v3i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, vector<3xi32>, i64) -> vector<8xi32>
    "llvm.return"(%1) : (vector<8xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_insertion_g", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<3xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<3xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.v8i32.v3i32, fastmathFlags = #llvm.fastmath<>} : (vector<8xi32>, vector<3xi32>, i64) -> vector<8xi32>
    "llvm.return"(%1) : (vector<8xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "valid_insertion_h", type = !llvm.func<vector<8xi32> (vector<8xi32>, vector<3xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<? x 4 x i32>, %arg1: vector<4xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.nxv4i32.v4i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 4 x i32>, vector<4xi32>, i64) -> !llvm.vec<? x 4 x i32>
    "llvm.return"(%1) : (!llvm.vec<? x 4 x i32>) -> ()
  }) {linkage = 10 : i64, sym_name = "scalable_insert", type = !llvm.func<vec<? x 4 x i32> (vec<? x 4 x i32>, vector<4xi32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
