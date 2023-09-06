module  {
  llvm.func @test_load_load_combine_metadata(%arg0: !llvm.ptr<ptr<i32>>, %arg1: !llvm.ptr<ptr<i32>>, %arg2: !llvm.ptr<ptr<i32>>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<ptr<i32>>
    %2 = llvm.load %arg0 : !llvm.ptr<ptr<i32>>
    llvm.store %0, %1 : !llvm.ptr<i32>
    llvm.store %0, %2 : !llvm.ptr<i32>
    llvm.return
  }
}
