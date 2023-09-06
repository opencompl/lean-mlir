module  {
  llvm.func @test21(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.ashr %arg0, %1  : i8
    %3 = llvm.and %2, %0  : i8
    llvm.return %3 : i8
  }
}
