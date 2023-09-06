module  {
  llvm.mlir.global weak @p(0 : i32) : i32
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @p : !llvm.ptr<i32>
    %1 = llvm.ptrtoint %0 : !llvm.ptr<i32> to i32
    %2 = llvm.mul %arg0, %1  : i32
    llvm.return %2 : i32
  }
}
