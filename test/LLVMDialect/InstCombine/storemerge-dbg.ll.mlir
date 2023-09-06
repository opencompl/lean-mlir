module  {
  llvm.func @escape(i32) -> i32
  llvm.func @foo(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i32 : (i32) -> !llvm.ptr<i32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %1, %2 : !llvm.ptr<i32>
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %0, %2 : !llvm.ptr<i32>
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %3 = llvm.load %2 : !llvm.ptr<i32>
    %4 = llvm.call @escape(%3) : (i32) -> i32
    llvm.return %4 : i32
  }
}
