module  {
  llvm.func @test(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }
}
