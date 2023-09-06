module  {
  llvm.func @memcmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i32>
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr<i8>, %arg1: i32) -> !llvm.ptr<i32> {
    %0 = llvm.call @memcmp(%arg0, %arg0, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i32>
    llvm.return %0 : !llvm.ptr<i32>
  }
}
