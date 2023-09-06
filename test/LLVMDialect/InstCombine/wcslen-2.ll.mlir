module  {
  llvm.mlir.global external constant @hello(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
  llvm.func @wcslen(!llvm.ptr<i32>, i32) -> i64
  llvm.func @test_no_simplify1() -> i64 {
    %0 = llvm.mlir.constant(187 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @hello : !llvm.ptr<array<6 x i32>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %4 = llvm.call @wcslen(%3, %0) : (!llvm.ptr<i32>, i32) -> i64
    llvm.return %4 : i64
  }
}
