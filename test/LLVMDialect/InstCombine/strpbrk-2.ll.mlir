module  {
  llvm.mlir.global external constant @hello("hello world\00")
  llvm.mlir.global external constant @w("w\00")
  llvm.func @strpbrk(!llvm.ptr<i8>, !llvm.ptr<i8>) -> i8
  llvm.func @test_no_simplify1() -> i8 {
    %0 = llvm.mlir.addressof @w : !llvm.ptr<array<2 x i8>>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @hello : !llvm.ptr<array<12 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<12 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.getelementptr %0[%1, %1] : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strpbrk(%3, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i8
    llvm.return %5 : i8
  }
}
