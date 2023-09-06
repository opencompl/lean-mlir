module  {
  llvm.func @test(%arg0: !llvm.ptr<i32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.addrspacecast %arg0 : !llvm.ptr<i32> to !llvm.ptr<i32, 1>
    llvm.store %0, %1 : !llvm.ptr<i32, 1>
    llvm.return %0 : i32
  }
}
