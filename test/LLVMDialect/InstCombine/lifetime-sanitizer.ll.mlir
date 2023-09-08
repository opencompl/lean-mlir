"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.lifetime.start.p0i8", type = !llvm.func<void (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.lifetime.end.p0i8", type = !llvm.func<void (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i8>
    "llvm.call"(%0, %2) {callee = @llvm.lifetime.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.call"(%0, %2) {callee = @llvm.lifetime.end.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.call"(%2) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "asan", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i8>
    "llvm.call"(%0, %2) {callee = @llvm.lifetime.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.call"(%0, %2) {callee = @llvm.lifetime.end.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.call"(%2) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "hwasan", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i8>
    "llvm.call"(%0, %2) {callee = @llvm.lifetime.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.call"(%0, %2) {callee = @llvm.lifetime.end.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.call"(%2) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "msan", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i8>
    "llvm.call"(%0, %2) {callee = @llvm.lifetime.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.call"(%0, %2) {callee = @llvm.lifetime.end.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.call"(%2) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "no_asan", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
