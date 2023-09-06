module  {
  llvm.func @test_load_combine_aa(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>, %arg2: !llvm.ptr<i32>, %arg3: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg3 : !llvm.ptr<i32>
    %2 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.store %1, %arg1 : !llvm.ptr<i32>
    llvm.store %2, %arg2 : !llvm.ptr<i32>
    llvm.return
  }
}
