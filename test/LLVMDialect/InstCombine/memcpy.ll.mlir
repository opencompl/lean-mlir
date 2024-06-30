"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "UnknownConstant", type = i128} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.p0i8.p0i8.i32", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.p0i8.p0i8.i64", type = !llvm.func<void (ptr<i8>, ptr<i8>, i64, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    "llvm.call"(%arg0, %arg0, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    "llvm.call"(%arg0, %arg0, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 17179869184 : i64} : () -> i64
    "llvm.call"(%arg0, %arg1, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<void (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @UnknownConstant} : () -> !llvm.ptr<i128>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<i128>) -> !llvm.ptr<i8>
    "llvm.call"(%3, %arg0, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memcpy_to_constant", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
