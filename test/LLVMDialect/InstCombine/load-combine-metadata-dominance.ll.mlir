module  {
  llvm.func @combine_metadata_dominance1(%arg0: !llvm.ptr<ptr<i32>>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<ptr<i32>>
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 : !llvm.ptr<ptr<i32>>
    llvm.store %0, %1 : !llvm.ptr<i32>
    llvm.store %0, %2 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @use(!llvm.ptr<i32>, i32) -> i32
  llvm.func @combine_metadata_dominance2(%arg0: !llvm.ptr<ptr<i32>>, %arg1: i1) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<ptr<i32>>
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 : !llvm.ptr<ptr<i32>>
    llvm.store %0, %1 : !llvm.ptr<i32>
    llvm.store %0, %2 : !llvm.ptr<i32>
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
}
