module  {
  llvm.func @test19(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i8
  }
}
