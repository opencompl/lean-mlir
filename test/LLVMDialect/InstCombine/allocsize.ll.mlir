"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "my_malloc", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "my_calloc", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %2 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %1) {callee = @my_malloc, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.store"(%3, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %4 = "llvm.call"(%3, %0, %0, %0) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.store"(%4, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_malloc", type = !llvm.func<void (ptr<ptr<i8>>, ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %3 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %3, %2, %1) {callee = @my_calloc, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    "llvm.store"(%4, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %5 = "llvm.call"(%4, %0, %0, %0) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.store"(%5, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_calloc", type = !llvm.func<void (ptr<ptr<i8>>, ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %2 = "llvm.call"(%1, %arg2) {callee = @my_malloc, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.store"(%2, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %3 = "llvm.call"(%2, %0, %0, %0) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.store"(%3, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_malloc_fails", type = !llvm.func<void (ptr<ptr<i8>>, ptr<i64>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %3 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %3, %arg2, %2) {callee = @my_calloc, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    "llvm.store"(%4, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %5 = "llvm.call"(%4, %1, %1, %1) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.store"(%5, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    %6 = "llvm.call"(%3, %3, %0, %arg2) {callee = @my_calloc, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    "llvm.store"(%6, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %7 = "llvm.call"(%6, %1, %1, %1) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.store"(%7, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_calloc_fails", type = !llvm.func<void (ptr<ptr<i8>>, ptr<i64>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "my_malloc_outofline", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "my_calloc_outofline", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %3 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %2) {callee = @my_malloc_outofline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.store"(%4, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %5 = "llvm.call"(%4, %1, %1, %1) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.store"(%5, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    %6 = "llvm.call"(%3, %3, %2, %0) {callee = @my_calloc_outofline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    "llvm.store"(%6, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %7 = "llvm.call"(%6, %1, %1, %1) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.store"(%7, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_outofline", type = !llvm.func<void (ptr<ptr<i8>>, ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "my_malloc_i64", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "my_tiny_calloc", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "my_varied_calloc", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i32, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 1000 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 8589934592 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 4 : i8} : () -> i8
    %4 = "llvm.mlir.constant"() {value = 127 : i8} : () -> i8
    %5 = "llvm.mlir.constant"() {value = false} : () -> i1
    %6 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %7 = "llvm.mlir.constant"() {value = -2147483647 : i32} : () -> i32
    %8 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %9 = "llvm.bitcast"(%arg1) : (!llvm.ptr<i32>) -> !llvm.ptr<i64>
    %10 = "llvm.call"(%8, %8, %7, %6) {callee = @my_calloc, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    "llvm.store"(%10, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %11 = "llvm.call"(%10, %5, %5, %5) {callee = @llvm.objectsize.i32.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    "llvm.store"(%11, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    %12 = "llvm.call"(%8, %8, %4, %3) {callee = @my_tiny_calloc, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i8, i8) -> !llvm.ptr<i8>
    "llvm.store"(%12, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %13 = "llvm.call"(%12, %5, %5, %5) {callee = @llvm.objectsize.i32.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    "llvm.store"(%13, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    %14 = "llvm.call"(%8, %2) {callee = @my_malloc_i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.store"(%14, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %15 = "llvm.call"(%14, %5, %5, %5) {callee = @llvm.objectsize.i32.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    "llvm.store"(%15, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    %16 = "llvm.call"(%14, %5, %5, %5) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.store"(%16, %9) : (i64, !llvm.ptr<i64>) -> ()
    %17 = "llvm.call"(%8, %8, %1, %0) {callee = @my_varied_calloc, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i8) -> !llvm.ptr<i8>
    "llvm.store"(%17, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %18 = "llvm.call"(%17, %5, %5, %5) {callee = @llvm.objectsize.i32.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    "llvm.store"(%18, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_overflow", type = !llvm.func<void (ptr<ptr<i8>>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    %2 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %1) {callee = @my_malloc, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.store"(%3, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %4 = "llvm.call"(%3, %0, %0, %0) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.store"(%4, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_nobuiltin", type = !llvm.func<void (ptr<ptr<i8>>, ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.objectsize.i32.p0i8", type = !llvm.func<i32 (ptr<i8>, i1, i1, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.objectsize.i64.p0i8", type = !llvm.func<i64 (ptr<i8>, i1, i1, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
