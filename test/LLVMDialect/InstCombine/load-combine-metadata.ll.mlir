module  {
  llvm.func @test_load_load_combine_metadata(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>, %arg2: !llvm.ptr<i32>) {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg1 : !llvm.ptr<i32>
    llvm.store %1, %arg2 : !llvm.ptr<i32>
    llvm.return
  }
}
