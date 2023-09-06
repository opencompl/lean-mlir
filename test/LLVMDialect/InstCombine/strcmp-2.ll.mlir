module  {
  llvm.mlir.global external constant @hello("hello\00")
  llvm.mlir.global external constant @hell("hell\00")
  llvm.func @strcmp(!llvm.ptr<i8>, !llvm.ptr<i8>) -> i16
  llvm.func @test_nosimplify() -> i16 {
    %0 = llvm.mlir.addressof @hello : !llvm.ptr<array<6 x i8>>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @hell : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.getelementptr %0[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strcmp(%3, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i16
    llvm.return %5 : i16
  }
}
