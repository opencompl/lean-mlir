module  {
  llvm.mlir.global external constant @test(dense<[1, 2, 3, 4]> : tensor<4xi32>) : !llvm.array<4 x i32>
  llvm.func @foo() -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.addressof @test : !llvm.ptr<array<4 x i32>>
    %2 = llvm.bitcast %1 : !llvm.ptr<array<4 x i32>> to !llvm.ptr<i8>
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %4 = llvm.bitcast %3 : !llvm.ptr<i8> to !llvm.ptr<i64>
    %5 = llvm.load %4 : !llvm.ptr<i64>
    llvm.return %5 : i64
  }
}
