"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hello", type = !llvm.array<6 x i32>, value = dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "wcslen", type = !llvm.func<i64 (ptr<i32>, i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 187 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<6 x i32>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<6 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %4 = "llvm.call"(%3, %0) {callee = @wcslen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>, i32) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify1", type = !llvm.func<i64 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
