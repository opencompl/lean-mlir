module  {
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    llvm.return %1 : i32
  }
}
