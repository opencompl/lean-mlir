module  {
  llvm.mlir.global external constant @hello(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
  llvm.func @wcslen(!llvm.ptr<i32>) -> i64
  llvm.func @test_no_simplify1() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @hello : !llvm.ptr<array<6 x i32>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<6 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %3 = llvm.call @wcslen(%2) : (!llvm.ptr<i32>) -> i64
    llvm.return %3 : i64
  }
}
