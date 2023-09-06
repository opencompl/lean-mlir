module  {
  llvm.func @test(%arg0: i31) -> i16 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(16384 : i32) : i32
    %2 = llvm.sext %arg0 : i31 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.lshr %3, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    llvm.return %5 : i16
  }
}
