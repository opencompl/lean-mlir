module  {
  llvm.func @memset(!llvm.ptr<i8>, i32, i32) -> i8
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr<i8>, %arg1: i32, %arg2: i32) -> i8 {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, i32, i32) -> i8
    llvm.return %0 : i8
  }
}
