module  {
  llvm.func @memcpy(!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i8
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) -> i8 {
    %0 = llvm.call @memcpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i8
    llvm.return %0 : i8
  }
}
