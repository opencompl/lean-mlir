module  {
  llvm.mlir.global external constant @hello_world("hello world\0A\00")
  llvm.func @sprintf(!llvm.ptr<i8>, !llvm.ptr<i8>, ...)
  llvm.func @test_simplify1(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr<array<13 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    llvm.call @sprintf(%arg0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
}
