module  {
  llvm.func @test(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.return
  }
}
