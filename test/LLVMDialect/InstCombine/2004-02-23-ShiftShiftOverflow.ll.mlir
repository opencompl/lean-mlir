module  {
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }
}
