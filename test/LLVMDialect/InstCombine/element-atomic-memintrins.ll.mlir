"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "gconst", type = !llvm.array<32 x i8>, value = "0123456789012345678901234567890\00"} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    "llvm.call"(%arg0, %2, %1, %0) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memset_zero_length", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    "llvm.call"(%arg0, %5, %4, %4) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %3, %4) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %2, %4) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %1, %4) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %0, %4) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memset_to_store", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    "llvm.call"(%arg0, %5, %4, %4) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %3, %3) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %2, %3) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %1, %3) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %0, %3) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memset_to_store_2", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    "llvm.call"(%arg0, %5, %4, %4) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %3, %3) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %2, %2) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %1, %2) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %0, %2) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memset_to_store_4", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    "llvm.call"(%arg0, %5, %4, %4) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %3, %3) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %2, %2) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %1, %1) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %0, %1) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memset_to_store_8", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    "llvm.call"(%arg0, %5, %4, %4) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %3, %3) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %2, %2) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %1, %1) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %5, %0, %0) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memset_to_store_16", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memset.element.unordered.atomic.p0i8.i32", type = !llvm.func<void (ptr<i8>, i8, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 32 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @gconst} : () -> !llvm.ptr<array<32 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<32 x i8>>, i64, i64) -> !llvm.ptr<i8>
    "llvm.call"(%arg0, %4, %1, %0) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memmove_to_memcpy", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %5, %4) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %5, %3) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %5, %2) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %5, %1) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %5, %0) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memmove_zero_length", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg0, %arg1, %4) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg0, %arg1, %3) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg0, %arg1, %2) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg0, %arg1, %1) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg0, %arg1, %0) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memmove_removed", type = !llvm.func<void (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %4, %4) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %3, %4) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %2, %4) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %4) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %0, %4) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memmove_loadstore", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %4, %4) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %3, %3) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %2, %3) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %3) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %0, %3) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memmove_loadstore_2", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %4, %4) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %3, %3) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %2, %2) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %2) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %0, %2) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memmove_loadstore_4", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %4, %4) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %3, %3) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %2, %2) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %1) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %0, %1) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memmove_loadstore_8", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %4, %4) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %3, %3) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %2, %2) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %1) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %0, %0) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memmove_loadstore_16", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %5, %4) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %5, %3) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %5, %2) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %5, %1) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %5, %0) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memcpy_zero_length", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg0, %arg1, %4) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg0, %arg1, %3) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg0, %arg1, %2) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg0, %arg1, %1) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg0, %arg1, %0) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memcpy_removed", type = !llvm.func<void (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %4, %4) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %3, %4) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %2, %4) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %4) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %0, %4) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memcpy_loadstore", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %4, %4) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %3, %3) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %2, %3) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %3) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %0, %3) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memcpy_loadstore_2", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %4, %4) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %3, %3) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %2, %2) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %2) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %0, %2) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memcpy_loadstore_4", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %4, %4) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %3, %3) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %2, %2) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %1) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %0, %1) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memcpy_loadstore_8", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %4, %4) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %3, %3) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %2, %2) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %1) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %0, %0) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_memcpy_loadstore_16", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = -8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    "llvm.cond_br"(%arg2)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.call"(%arg0, %arg1, %3, %2) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %2) {callee = @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %3, %2) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %arg1, %1, %2) {callee = @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    "llvm.call"(%arg0, %0, %3, %2) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.call"(%arg0, %0, %1, %2) {callee = @llvm.memset.element.unordered.atomic.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_undefined", type = !llvm.func<void (ptr<i8>, ptr<i8>, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
