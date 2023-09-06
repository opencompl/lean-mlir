module  {
  llvm.func @test1(%arg0: i43) -> i19 {
    %0 = llvm.mlir.constant(1 : i43) : i43
    %1 = llvm.bitcast %arg0 : i43 to i43
    %2 = llvm.and %1, %0  : i43
    %3 = llvm.trunc %2 : i43 to i19
    llvm.return %3 : i19
  }
  llvm.func @test2(%arg0: i677) -> i73 {
    %0 = llvm.mlir.constant(1 : i677) : i677
    %1 = llvm.bitcast %arg0 : i677 to i677
    %2 = llvm.and %1, %0  : i677
    %3 = llvm.trunc %2 : i677 to i73
    llvm.return %3 : i73
  }
}
