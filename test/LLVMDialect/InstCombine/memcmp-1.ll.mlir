"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "foo", type = !llvm.array<4 x i8>, value = "foo\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hel", type = !llvm.array<4 x i8>, value = "hel\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hello_u", type = !llvm.array<8 x i8>, value = "hello_u\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memcmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg0, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify1", type = !llvm.func<i32 (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify2", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify3", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @hello_u} : () -> !llvm.ptr<array<8 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @hel} : () -> !llvm.ptr<array<4 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %2) : (!llvm.ptr<array<8 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%4, %5, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify4", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @foo} : () -> !llvm.ptr<array<4 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @hel} : () -> !llvm.ptr<array<4 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %2) : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%4, %5, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify5", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @hel} : () -> !llvm.ptr<array<4 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @foo} : () -> !llvm.ptr<array<4 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %2) : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%4, %5, %0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify6", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i64>
    %4 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i64>
    "llvm.store"(%arg0, %3) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.store"(%arg1, %4) : (i64, !llvm.ptr<i64>) -> ()
    %5 = "llvm.bitcast"(%3) : (!llvm.ptr<i64>) -> !llvm.ptr<i8>
    %6 = "llvm.bitcast"(%4) : (!llvm.ptr<i64>) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%5, %6, %1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    %8 = "llvm.icmp"(%7, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%8) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify7", type = !llvm.func<i1 (i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i32>
    %4 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i32>
    "llvm.store"(%arg0, %3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.store"(%arg1, %4) : (i32, !llvm.ptr<i32>) -> ()
    %5 = "llvm.bitcast"(%3) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %6 = "llvm.bitcast"(%4) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%5, %6, %1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    %8 = "llvm.icmp"(%7, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%8) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify8", type = !llvm.func<i1 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i16>
    %4 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i16>
    "llvm.store"(%arg0, %3) : (i16, !llvm.ptr<i16>) -> ()
    "llvm.store"(%arg1, %4) : (i16, !llvm.ptr<i16>) -> ()
    %5 = "llvm.bitcast"(%3) : (!llvm.ptr<i16>) -> !llvm.ptr<i8>
    %6 = "llvm.bitcast"(%4) : (!llvm.ptr<i16>) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%5, %6, %1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    %8 = "llvm.icmp"(%7, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%8) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify9", type = !llvm.func<i1 (i16, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify10", type = !llvm.func<i1 (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
