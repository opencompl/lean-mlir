"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "ax", type = !llvm.array<0 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "bx", type = !llvm.array<0 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a12345", type = !llvm.array<5 x i8>, value = "\01\02\03\04\05"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "a123456", type = !llvm.array<6 x i8>, value = "\01\02\03\04\05\06"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strncmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4294967296 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @bx} : () -> !llvm.ptr<array<0 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %2) : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%4, %5, %0) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strncmp_ax_bx_uimax_p1", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4294967296 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @bx} : () -> !llvm.ptr<array<0 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @ax} : () -> !llvm.ptr<array<0 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %2) : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%4, %5, %0) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strncmp_ax_bx_uimax_p2", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4294967297 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @a123456} : () -> !llvm.ptr<array<6 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @a12345} : () -> !llvm.ptr<array<5 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %2) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%4, %5, %0) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strncmp_a12345_2_uimax_p2", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 4294967298 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @a12345} : () -> !llvm.ptr<array<5 x i8>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @a123456} : () -> !llvm.ptr<array<6 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.getelementptr"(%1, %2, %2) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%4, %5, %0) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strncmp_a12345_2_uimax_p3", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
