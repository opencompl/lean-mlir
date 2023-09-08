"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = "charbuf", type = !llvm.array<4 x i8>, value = "\00\00\00\01"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = "intbuf_unaligned", type = !llvm.array<4 x i16>, value = dense<[1, 2, 3, 4]> : tensor<4xi16>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 0 : i64, sym_name = "intbuf", type = !llvm.array<2 x i32>, value = dense<[0, 1]> : tensor<2xi32>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memcmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @charbuf} : () -> !llvm.ptr<array<4 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %4, %1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %6 = "llvm.icmp"(%5, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_4bytes_unaligned_constant_i8", type = !llvm.func<i1 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @intbuf_unaligned} : () -> !llvm.ptr<array<4 x i16>>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<array<4 x i16>>) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %5 = "llvm.icmp"(%4, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_4bytes_unaligned_constant_i16", type = !llvm.func<i1 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @intbuf} : () -> !llvm.ptr<array<2 x i32>>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<array<2 x i32>>) -> !llvm.ptr<i8>
    %4 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %6 = "llvm.mlir.addressof"() {global_name = @intbuf} : () -> !llvm.ptr<array<2 x i32>>
    %7 = "llvm.getelementptr"(%6, %5, %4) : (!llvm.ptr<array<2 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %8 = "llvm.bitcast"(%7) : (!llvm.ptr<i32>) -> !llvm.ptr<i8>
    %9 = "llvm.call"(%8, %3, %1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %10 = "llvm.icmp"(%9, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%10) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_3bytes_aligned_constant_i32", type = !llvm.func<i1 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %2 = "llvm.bitcast"(%arg0) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    %3 = "llvm.load"(%2) : (!llvm.ptr<i32>) -> i32
    %4 = "llvm.call"(%arg0, %arg1, %1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %5 = "llvm.icmp"(%4, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "memcmp_4bytes_one_unaligned_i8", type = !llvm.func<i1 (ptr<i8>, ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
