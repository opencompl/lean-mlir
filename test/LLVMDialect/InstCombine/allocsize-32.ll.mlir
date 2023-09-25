"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "my_malloc", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5000000000 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 100 : i64} : () -> i64
    %3 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %2) {callee = @my_malloc, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.store"(%4, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %5 = "llvm.call"(%4, %1, %1, %1) {callee = @llvm.objectsize.i32.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    "llvm.store"(%5, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    %6 = "llvm.call"(%3, %0) {callee = @my_malloc, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.store"(%6, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %7 = "llvm.call"(%6, %1, %1, %1) {callee = @llvm.objectsize.i32.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    "llvm.store"(%7, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_malloc", type = !llvm.func<void (ptr<ptr<i8>>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.objectsize.i32.p0i8", type = !llvm.func<i32 (ptr<i8>, i1, i1, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
