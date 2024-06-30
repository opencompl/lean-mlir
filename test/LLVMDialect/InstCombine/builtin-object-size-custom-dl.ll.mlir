"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %3 = "llvm.call"(%arg0) {callee = @malloc, fastmathFlags = #llvm.fastmath<>} : (i64) -> !llvm.ptr<i8>
    %4 = "llvm.getelementptr"(%3, %2) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %1, %0, %0) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "objsize1_custom_idx", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 28 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %6 = "llvm.alloca"(%5) : (i32) -> !llvm.ptr<struct<"struct.V", (array<10 x i8>, i32, array<10 x i8>)>>
    %7 = "llvm.bitcast"(%6) : (!llvm.ptr<struct<"struct.V", (array<10 x i8>, i32, array<10 x i8>)>>) -> !llvm.ptr<i8>
    "llvm.call"(%4, %7) {callee = @llvm.lifetime.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    %8 = "llvm.getelementptr"(%6, %3, %3) : (!llvm.ptr<struct<"struct.V", (array<10 x i8>, i32, array<10 x i8>)>>, i32, i32) -> !llvm.ptr<array<10 x i8>>
    %9 = "llvm.getelementptr"(%8, %2, %1) : (!llvm.ptr<array<10 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %10 = "llvm.call"(%9, %0, %0, %0) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    %11 = "llvm.trunc"(%10) : (i64) -> i32
    "llvm.call"(%4, %7) {callee = @llvm.lifetime.end.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.return"(%11) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "objsize2_custom_idx", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.lifetime.start.p0i8", type = !llvm.func<void (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.lifetime.end.p0i8", type = !llvm.func<void (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "malloc", type = !llvm.func<ptr<i8> (i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.objectsize.i64.p0i8", type = !llvm.func<i64 (ptr<i8>, i1, i1, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
