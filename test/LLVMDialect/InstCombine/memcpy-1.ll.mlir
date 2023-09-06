module  {
  llvm.func @memcpy(!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
  llvm.func @test_simplify1(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) -> !llvm.ptr<i8> {
    %0 = llvm.call @memcpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) -> !llvm.ptr<i8> {
    %0 = llvm.call @memcpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @get_dest() -> !llvm.ptr<i8>
  llvm.func @test_simplify3(%arg0: !llvm.ptr<i8>, %arg1: i32) -> !llvm.ptr<i8> {
    %0 = llvm.call @get_dest() : () -> !llvm.ptr<i8>
    %1 = llvm.call @memcpy(%0, %arg0, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @test_no_incompatible_attr(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) -> !llvm.ptr<i8> {
    %0 = llvm.call @memcpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) -> !llvm.ptr<i8> {
    %0 = llvm.call @memcpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
}
