"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hello", type = !llvm.array<12 x i8>, value = "hello world\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "w", type = !llvm.array<2 x i8>, value = "w\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strpbrk", type = !llvm.func<i8 (ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @w} : () -> !llvm.ptr<array<2 x i8>>
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<12 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<12 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.getelementptr"(%0, %1, %1) : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%3, %4) {callee = @strpbrk, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i8
    "llvm.return"(%5) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify1", type = !llvm.func<i8 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
