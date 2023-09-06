module  {
  llvm.func @test(%arg0: !llvm.ptr<i32>) -> !llvm.ptr<i32> {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<i32> to i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr<i32>
    llvm.return %1 : !llvm.ptr<i32>
  }
}
