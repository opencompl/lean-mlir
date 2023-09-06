module  {
  llvm.func @test(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.lshr %0, %1  : i32
    llvm.return %2 : i32
  }
}
