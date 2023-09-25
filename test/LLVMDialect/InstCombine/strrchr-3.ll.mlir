"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "s10", type = !llvm.array<11 x i8>, value = "0123456789\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strrchr", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @s10} : () -> !llvm.ptr<array<11 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0) {callee = @strrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "fold_strrchr_sp10_x", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @s10} : () -> !llvm.ptr<array<11 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0) {callee = @strrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strrchr_sp9_x", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @s10} : () -> !llvm.ptr<array<11 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0) {callee = @strrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strrchr_sp2_x", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @s10} : () -> !llvm.ptr<array<11 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %arg0) {callee = @strrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "call_strrchr_sp1_x", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
