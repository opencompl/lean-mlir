"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "X", type = i8, value = 0 : i8} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "Y", type = i8, value = 12 : i8} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memmove.p0i8.p0i8.i32", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.p0i8.p0i8.i32", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memset.p0i8.i32", type = !llvm.func<void (ptr<i8>, i8, i32, i1)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 123 : i8} : () -> i8
    %1 = "llvm.mlir.addressof"() {global_name = @X} : () -> !llvm.ptr<i8>
    %2 = "llvm.mlir.addressof"() {global_name = @Y} : () -> !llvm.ptr<i8>
    %3 = "llvm.mlir.addressof"() {global_name = @X} : () -> !llvm.ptr<i8>
    %4 = "llvm.mlir.constant"() {value = false} : () -> i1
    %5 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %6 = "llvm.mlir.addressof"() {global_name = @Y} : () -> !llvm.ptr<i8>
    %7 = "llvm.mlir.addressof"() {global_name = @X} : () -> !llvm.ptr<i8>
    "llvm.call"(%7, %6, %5, %4) {callee = @llvm.memmove.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.call"(%3, %2, %5, %4) {callee = @llvm.memcpy.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.call"(%1, %0, %5, %4) {callee = @llvm.memset.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "zero_byte_test", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
