module  {
  llvm.mlir.global external constant @hello("hello\00")
  llvm.func @strlen(!llvm.ptr<i8>, i32) -> i32
  llvm.func @test_no_simplify1() -> i32 {
    %0 = llvm.mlir.constant(187 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @hello : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strlen(%3, %0) : (!llvm.ptr<i8>, i32) -> i32
    llvm.return %4 : i32
  }
}
