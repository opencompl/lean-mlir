"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<array<7 x i8>>
    %5 = "llvm.getelementptr"(%4, %2, %2) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    "llvm.call"(%arg0, %5, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %3 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<array<7 x i8>>
    %6 = "llvm.getelementptr"(%5, %3, %3) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    "llvm.store"(%2, %6) : (i8, !llvm.ptr<i8>) -> ()
    "llvm.call"(%arg0, %6, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<array<7 x i8>>
    %5 = "llvm.getelementptr"(%4, %2, %2) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    "llvm.call"(%arg0, %5, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<array<7 x i8>>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<array<7 x i8>>) -> !llvm.ptr<i8>
    "llvm.call"(%arg0, %4, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<array<7 x i8>>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<array<7 x i8>>) -> !llvm.ptr<i32>
    %5 = "llvm.getelementptr"(%4, %2) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %6 = "llvm.bitcast"(%5) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    "llvm.call"(%arg0, %6, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 42 : i16} : () -> i16
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<array<7 x i8>>
    %5 = "llvm.bitcast"(%4) : (!llvm.ptr<array<7 x i8>>) -> !llvm.ptr<i16>
    %6 = "llvm.getelementptr"(%5, %3) : (!llvm.ptr<i16>, i32) -> !llvm.ptr<i16>
    "llvm.store"(%2, %6) : (i16, !llvm.ptr<i16>) -> ()
    %7 = "llvm.bitcast"(%6) : (!llvm.ptr<i16>) -> !llvm.ptr<i8>
    "llvm.call"(%arg0, %7, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.p0i8.p0i8.i64", type = !llvm.func<void (ptr<i8>, ptr<i8>, i64, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
