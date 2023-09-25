"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = "test.data", type = !llvm.array<8 x i32>, value = dense<[0, 1, 2, 3, 4, 5, 6, 7]> : tensor<8xi32>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32, 1>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @test.data} : () -> !llvm.ptr<array<8 x i32>>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8, 2>
    %5 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %6 = "llvm.alloca"(%5) : (i32) -> !llvm.ptr<array<8 x i32>>
    %7 = "llvm.bitcast"(%6) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8>
    "llvm.call"(%7, %4, %2, %1) {callee = @llvm.memcpy.p0i8.p2i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %8 = "llvm.getelementptr"(%6, %0, %arg1) : (!llvm.ptr<array<8 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %9 = "llvm.load"(%8) : (!llvm.ptr<i32>) -> i32
    %10 = "llvm.getelementptr"(%arg0, %arg1) : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    "llvm.store"(%9, %10) : (i32, !llvm.ptr<i32, 1>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_load", type = !llvm.func<void (ptr<i32, 1>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32, 1>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @test.data} : () -> !llvm.ptr<array<8 x i32>>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8, 2>
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<array<8 x i32>>
    %6 = "llvm.bitcast"(%5) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8>
    "llvm.call"(%6, %3, %1, %0) {callee = @llvm.memcpy.p0i8.p2i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %7 = "llvm.bitcast"(%6) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    %8 = "llvm.getelementptr"(%7, %arg1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %9 = "llvm.load"(%8) : (!llvm.ptr<i32>) -> i32
    %10 = "llvm.getelementptr"(%arg0, %arg1) : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    "llvm.store"(%9, %10) : (i32, !llvm.ptr<i32, 1>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_bitcast_chain", type = !llvm.func<void (ptr<i32, 1>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32, 1>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @test.data} : () -> !llvm.ptr<array<8 x i32>>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8, 2>
    %5 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %6 = "llvm.alloca"(%5) : (i32) -> !llvm.ptr<array<8 x i32>>
    %7 = "llvm.bitcast"(%6) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8>
    "llvm.call"(%7, %4, %2, %1) {callee = @llvm.memcpy.p0i8.p2i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %8 = "llvm.getelementptr"(%6, %0, %arg1) : (!llvm.ptr<array<8 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %9 = "llvm.call"(%8) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>) -> i32
    %10 = "llvm.getelementptr"(%arg0, %arg1) : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    "llvm.store"(%9, %10) : (i32, !llvm.ptr<i32, 1>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_call", type = !llvm.func<void (ptr<i32, 1>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32, 1>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @test.data} : () -> !llvm.ptr<array<8 x i32>>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8, 2>
    %5 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %6 = "llvm.alloca"(%5) : (i32) -> !llvm.ptr<array<8 x i32>>
    %7 = "llvm.bitcast"(%6) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8>
    "llvm.call"(%7, %4, %2, %1) {callee = @llvm.memcpy.p0i8.p2i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %8 = "llvm.getelementptr"(%6, %0, %arg1) : (!llvm.ptr<array<8 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %9 = "llvm.call"(%8) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>) -> i32
    %10 = "llvm.getelementptr"(%arg0, %arg1) : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    "llvm.store"(%9, %10) : (i32, !llvm.ptr<i32, 1>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_call_no_null_opt", type = !llvm.func<void (ptr<i32, 1>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32, 1>, %arg1: i64, %arg2: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @test.data} : () -> !llvm.ptr<array<8 x i32>>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8, 2>
    %5 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %6 = "llvm.alloca"(%5) : (i32) -> !llvm.ptr<array<8 x i32>>
    %7 = "llvm.bitcast"(%6) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8>
    "llvm.call"(%7, %4, %2, %1) {callee = @llvm.memcpy.p0i8.p2i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %8 = "llvm.getelementptr"(%6, %0, %arg1) : (!llvm.ptr<array<8 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %9 = "llvm.load"(%8) : (!llvm.ptr<i32>) -> i32
    %10 = "llvm.getelementptr"(%arg0, %arg1) : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    "llvm.store"(%9, %10) : (i32, !llvm.ptr<i32, 1>) -> ()
    %11 = "llvm.call"(%8) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>) -> i32
    %12 = "llvm.getelementptr"(%arg0, %arg2) : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    "llvm.store"(%11, %12) : (i32, !llvm.ptr<i32, 1>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_and_call", type = !llvm.func<void (ptr<i32, 1>, i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32, 1>, %arg1: i64, %arg2: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @test.data} : () -> !llvm.ptr<array<8 x i32>>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8, 2>
    %5 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %6 = "llvm.alloca"(%5) : (i32) -> !llvm.ptr<array<8 x i32>>
    %7 = "llvm.bitcast"(%6) : (!llvm.ptr<array<8 x i32>>) -> !llvm.ptr<i8>
    "llvm.call"(%7, %4, %2, %1) {callee = @llvm.memcpy.p0i8.p2i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %8 = "llvm.getelementptr"(%6, %0, %arg1) : (!llvm.ptr<array<8 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %9 = "llvm.load"(%8) : (!llvm.ptr<i32>) -> i32
    %10 = "llvm.getelementptr"(%arg0, %arg1) : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    "llvm.store"(%9, %10) : (i32, !llvm.ptr<i32, 1>) -> ()
    %11 = "llvm.call"(%8) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>) -> i32
    %12 = "llvm.getelementptr"(%arg0, %arg2) : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    "llvm.store"(%11, %12) : (i32, !llvm.ptr<i32, 1>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_load_and_call_no_null_opt", type = !llvm.func<void (ptr<i32, 1>, i64, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.p0i8.p2i8.i64", type = !llvm.func<void (ptr<i8>, ptr<i8, 2>, i64, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 (ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
