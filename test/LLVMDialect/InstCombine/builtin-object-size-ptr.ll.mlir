"module"() ( {
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
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 10 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 9 : i8} : () -> i8
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<array<10 x i8>>
    %5 = "llvm.bitcast"(%4) : (!llvm.ptr<array<10 x i8>>) -> !llvm.ptr<i8>
    "llvm.call"(%5, %2, %1, %0) {callee = @llvm.memset.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i64, i1) -> ()
    %6 = "llvm.call"(%1, %5) {callee = @llvm.invariant.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> !llvm.ptr<struct<()>>
    "llvm.call"(%6, %1, %5) {callee = @llvm.invariant.end.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<()>>, i64, !llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "PR43723", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<struct<()>>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 10 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 9 : i8} : () -> i8
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<array<10 x i8>>
    %5 = "llvm.bitcast"(%4) : (!llvm.ptr<array<10 x i8>>) -> !llvm.ptr<i8>
    "llvm.call"(%5, %2, %1, %0) {callee = @llvm.memset.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i64, i1) -> ()
    %6 = "llvm.call"(%1, %5) {callee = @llvm.invariant.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> !llvm.ptr<struct<()>>
    "llvm.call"(%6, %1, %5) {callee = @llvm.invariant.end.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<()>>, i64, !llvm.ptr<i8>) -> ()
    "llvm.store"(%6, %arg0) : (!llvm.ptr<struct<()>>, !llvm.ptr<ptr<struct<()>>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "unknown_use_of_invariant_start", type = !llvm.func<void (ptr<ptr<struct<()>>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%0, %2) {callee = @llvm.invariant.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> !llvm.ptr<struct<()>>
    "llvm.return"(%3) : (!llvm.ptr<struct<()>>) -> ()
  }) {linkage = 10 : i64, sym_name = "minimal_invariant_start_use", type = !llvm.func<ptr<struct<()>> (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.lifetime.start.p0i8", type = !llvm.func<void (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.lifetime.end.p0i8", type = !llvm.func<void (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memset.p0i8.i64", type = !llvm.func<void (ptr<i8>, i8, i64, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.invariant.start.p0i8", type = !llvm.func<ptr<struct<()>> (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.invariant.end.p0i8", type = !llvm.func<void (ptr<struct<()>>, i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.objectsize.i64.p0i8", type = !llvm.func<i64 (ptr<i8>, i1, i1, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
