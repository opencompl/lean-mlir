module  {
  llvm.func @test(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i32 : (i32) -> !llvm.ptr<i32>
    %4 = llvm.alloca %2 x i32 : (i32) -> !llvm.ptr<i32>
    llvm.store %2, %3 : !llvm.ptr<i32>
    llvm.store %1, %4 : !llvm.ptr<i32>
    llvm.cond_br %arg0, ^bb1, ^bb2(%4 : !llvm.ptr<i32>)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%3 : !llvm.ptr<i32>)
  ^bb2(%5: !llvm.ptr<i32>):  // 2 preds: ^bb0, ^bb1
    llvm.store %0, %3 : !llvm.ptr<i32>
    %6 = llvm.load %5 : !llvm.ptr<i32>
    llvm.return %6 : i32
  }
}
