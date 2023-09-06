module  {
  llvm.func @memrchr(!llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
  llvm.func @test1(%arg0: !llvm.ptr<i8>, %arg1: i32, %arg2: i32) -> !llvm.ptr<i8> {
    %0 = llvm.call @memrchr(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @test2(%arg0: !llvm.ptr<i8>, %arg1: i32, %arg2: i32) -> !llvm.ptr<i8> {
    %0 = llvm.call @memrchr(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @test3(%arg0: !llvm.ptr<i8>, %arg1: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @memrchr(%arg0, %arg1, %0) : (!llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @test4(%arg0: !llvm.ptr<i8>, %arg1: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @memrchr(%arg0, %arg1, %0) : (!llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @test5(%arg0: !llvm.ptr<i8>, %arg1: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memrchr(%arg0, %arg1, %0) : (!llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
}
