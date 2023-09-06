module  {
  llvm.func @test_load_store_load_combine(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<f32>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    %1 = llvm.sitofp %0 : i32 to f32
    llvm.store %1, %arg1 : !llvm.ptr<f32>
    %2 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.return %2 : i32
  }
}
