module  {
  llvm.func @test(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(4294967294 : i64) : i64
    %2 = llvm.or %arg0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.srem %3, %0  : i32
    llvm.return %4 : i32
  }
}
