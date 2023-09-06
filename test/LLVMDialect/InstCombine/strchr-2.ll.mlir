module  {
  llvm.mlir.global external constant @hello("hello world\\n\00")
  llvm.mlir.global external @chr(0 : i8) : i8
  llvm.func @strchr(!llvm.ptr<i8>, i32) -> i8
  llvm.func @test_nosimplify1() {
    %0 = llvm.mlir.addressof @chr : !llvm.ptr<i8>
    %1 = llvm.mlir.constant(119 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @hello : !llvm.ptr<array<14 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<14 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strchr(%4, %1) : (!llvm.ptr<i8>, i32) -> i8
    llvm.store %5, %0 : !llvm.ptr<i8>
    llvm.return
  }
}
