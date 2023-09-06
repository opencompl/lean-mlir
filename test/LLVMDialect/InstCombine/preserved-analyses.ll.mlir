module  {
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.add %arg0, %1  : i32
    %3 = llvm.add %2, %0  : i32
    llvm.return %3 : i32
  }
}
