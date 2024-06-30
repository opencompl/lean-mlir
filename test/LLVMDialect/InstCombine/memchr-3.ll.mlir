"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "ax", type = !llvm.array<0 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a12345", type = !llvm.array<5 x i8>, value = "\01\02\03\04\05"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memchr", type = !llvm.func<ptr<i8> (ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @a12345} : () -> !llvm.ptr<array<5 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %1, %0) {callee = @memchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memchr_a12345_1_1", type = !llvm.func<ptr<i8> ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @a12345} : () -> !llvm.ptr<array<5 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %1, %0) {callee = @memchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memchr_a12345_2_1", type = !llvm.func<ptr<i8> ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 257 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %1, %0) {callee = @memchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%5) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memchr_ax_257_1", type = !llvm.func<ptr<i8> (i32, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %0) {callee = @memchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memchr_ax_c_1", type = !llvm.func<ptr<i8> (i32, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
