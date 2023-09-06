module  {
  llvm.func @test(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    llvm.return
  ^bb1(%1: i32):  // pred: ^bb1
    %2 = llvm.sdiv %1, %0  : i32
    llvm.store %2, %arg0 : !llvm.ptr<i32>
    llvm.br ^bb1(%2 : i32)
  }
}
