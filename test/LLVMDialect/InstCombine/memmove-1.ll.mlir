module  {
  llvm.func @memmove(!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
  llvm.func @test_simplify1(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) -> !llvm.ptr<i8> {
    %0 = llvm.call @memmove(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) -> !llvm.ptr<i8> {
    %0 = llvm.call @memmove(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) -> !llvm.ptr<i8> {
    %0 = llvm.call @memmove(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @test_no_incompatible_attr(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) -> !llvm.ptr<i8> {
    %0 = llvm.call @memmove(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
}
