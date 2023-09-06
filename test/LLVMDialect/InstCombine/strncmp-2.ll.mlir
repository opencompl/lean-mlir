module  {
  llvm.mlir.global external constant @hello("hello\00")
  llvm.mlir.global external constant @hell("hell\00")
  llvm.func @strncmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i16
  llvm.func @test_nosimplify() -> i16 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.addressof @hello : !llvm.ptr<array<6 x i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @hell : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @strncmp(%4, %5, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i16
    llvm.return %6 : i16
  }
}
