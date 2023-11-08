"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "ax", type = !llvm.array<0 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "ax1", type = !llvm.array<1 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a12345", type = !llvm.array<5 x i8>, value = "\01\02\03\04\05"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memrchr", type = !llvm.func<ptr<i8> (ptr<i8>, i32, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4294967296 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a12345} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "call_memrchr_a12345_c_ui32max_p1", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4294967297 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @ax1} : () -> !llvm.ptr<array<1 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<1 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "call_memrchr_ax1_c_ui32max_p2", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4294967297 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "call_memrchr_ax_c_ui32max_p2", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a12345} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "call_memrchr_a12345_c_6", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @a12345} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "call_memrchr_a12345_c_szmax", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
