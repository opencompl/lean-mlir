"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a11111", type = !llvm.array<5 x i8>, value = "\01\01\01\01\01"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a1110111", type = !llvm.array<7 x i8>, value = "\01\01\01\00\01\01\01"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memrchr", type = !llvm.func<ptr<i8> (ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a11111} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memrchr_a11111_c_5", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @a11111} : () -> !llvm.ptr<array<5 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %arg0, %arg1) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%3) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memrchr_a11111_c_n", type = !llvm.func<ptr<i8> (i32, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a1110111} : () -> !llvm.ptr<array<7 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_memrchr_a1110111_c_3", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a1110111} : () -> !llvm.ptr<array<7 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "call_memrchr_a1110111_c_4", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a1110111} : () -> !llvm.ptr<array<7 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "call_memrchr_a1110111_c_7", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @a1110111} : () -> !llvm.ptr<array<7 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%2, %arg0, %arg1) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%3) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "call_memrchr_a1110111_c_n", type = !llvm.func<ptr<i8> (i32, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
