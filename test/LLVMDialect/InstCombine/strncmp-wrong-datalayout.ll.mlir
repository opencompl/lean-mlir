module  {
  llvm.func @strncmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
  llvm.func @test6(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    llvm.return %1 : i32
  }
}
