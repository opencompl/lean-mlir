module  {
  llvm.func @test(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.ashr %1, %0  : i64
    llvm.return %2 : i64
  }
}
