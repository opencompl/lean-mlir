"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "test", type = !llvm.array<4 x i32>, value = dense<[1, 2, 3, 4]> : tensor<4xi32>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %1 = "llvm.mlir.addressof"() {global_name = @test} : () -> !llvm.ptr<array<4 x i32>>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<array<4 x i32>>) -> !llvm.ptr<i8>
    %3 = "llvm.getelementptr"(%2, %0) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<i8>) -> !llvm.ptr<i64>
    %5 = "llvm.load"(%4) : (!llvm.ptr<i64>) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i64 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
