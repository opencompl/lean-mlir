"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a5", type = !llvm.array<5 x i8>, value = "12345"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memcmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %0) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%4, %5, %arg0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memcmp_a5_a5p5_n", type = !llvm.func<i32 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%0, %2, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%4, %5, %arg0) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memcmp_a5p5_a5p5_n", type = !llvm.func<i32 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @a5} : () -> !llvm.ptr<array<5 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %arg0) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %0) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%4, %5, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memcmp_a5pi_a5p5_n", type = !llvm.func<i32 (i32, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
