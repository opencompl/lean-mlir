"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.p0i8.p0i8.i64", type = !llvm.func<void (ptr<i8>, ptr<i8>, i64, i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"A", (f32)>>, %arg1: !llvm.ptr<struct<"A", (f32)>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %2 = "llvm.bitcast"(%arg0) : (!llvm.ptr<struct<"A", (f32)>>) -> !llvm.ptr<i8>
    %3 = "llvm.bitcast"(%arg1) : (!llvm.ptr<struct<"A", (f32)>>) -> !llvm.ptr<i8>
    "llvm.call"(%2, %3, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<void (ptr<struct<"A", (f32)>>, ptr<struct<"A", (f32)>>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %3 = "llvm.mlir.undef"() : () -> !llvm.ptr<i8>
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<struct<"B", (ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>)>>
    %6 = "llvm.bitcast"(%5) : (!llvm.ptr<struct<"B", (ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>)>>) -> !llvm.ptr<i8>
    "llvm.call"(%6, %3, %2, %1) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    %7 = "llvm.getelementptr"(%5, %0, %0) : (!llvm.ptr<struct<"B", (ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>)>>, i32, i32) -> !llvm.ptr<ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>>
    %8 = "llvm.load"(%7) : (!llvm.ptr<ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>>) -> !llvm.ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>
    "llvm.return"(%7) : (!llvm.ptr<ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>>) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<ptr<ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>> ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
