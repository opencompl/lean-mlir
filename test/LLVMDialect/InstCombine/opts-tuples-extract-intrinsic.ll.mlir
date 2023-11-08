"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<? x 64 x i8>, %arg1: !llvm.vec<? x 16 x i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 48 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.nxv64i8.nxv16i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 64 x i8>, !llvm.vec<? x 16 x i8>, i64) -> !llvm.vec<? x 64 x i8>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.vector.extract.nxv16i8.nxv64i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 64 x i8>, i64) -> !llvm.vec<? x 16 x i8>
    "llvm.return"(%2) : (!llvm.vec<? x 16 x i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_extract_insert_same_idx", type = !llvm.func<vec<? x 16 x i8> (vec<? x 64 x i8>, vec<? x 16 x i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<? x 64 x i8>, %arg1: !llvm.vec<? x 16 x i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 48 : i64} : () -> i64
    %2 = "llvm.call"(%arg0, %arg1, %1) {callee = @llvm.vector.insert.nxv64i8.nxv16i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 64 x i8>, !llvm.vec<? x 16 x i8>, i64) -> !llvm.vec<? x 64 x i8>
    %3 = "llvm.call"(%2, %0) {callee = @llvm.vector.extract.nxv16i8.nxv64i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 64 x i8>, i64) -> !llvm.vec<? x 16 x i8>
    "llvm.return"(%3) : (!llvm.vec<? x 16 x i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_extract_insert_dif_idx", type = !llvm.func<vec<? x 16 x i8> (vec<? x 64 x i8>, vec<? x 16 x i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<? x 64 x i8>, %arg1: !llvm.vec<? x 16 x i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.vector.insert.nxv64i8.nxv16i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 64 x i8>, !llvm.vec<? x 16 x i8>, i64) -> !llvm.vec<? x 64 x i8>
    %2 = "llvm.call"(%1, %0) {callee = @llvm.vector.extract.nxv32i8.nxv64i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 64 x i8>, i64) -> !llvm.vec<? x 32 x i8>
    "llvm.return"(%2) : (!llvm.vec<? x 32 x i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "neg_test_extract_insert_same_idx_dif_ret_size", type = !llvm.func<vec<? x 32 x i8> (vec<? x 64 x i8>, vec<? x 16 x i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.insert.nxv64i8.nxv16i8", type = !llvm.func<vec<? x 64 x i8> (vec<? x 64 x i8>, vec<? x 16 x i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.extract.nxv16i8.nxv64i8", type = !llvm.func<vec<? x 16 x i8> (vec<? x 64 x i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.extract.nxv32i8.nxv64i8", type = !llvm.func<vec<? x 32 x i8> (vec<? x 64 x i8>, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
