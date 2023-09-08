"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hello", type = !llvm.array<14 x i8>, value = "hello world\\n\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "chr", type = i8, value = 0 : i8} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strrchr", type = !llvm.func<i8 (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @chr} : () -> !llvm.ptr<i8>
    %1 = "llvm.mlir.constant"() {value = 119 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<14 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<14 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %1) {callee = @strrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> i8
    "llvm.store"(%5, %0) : (i8, !llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_nosimplify1", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
