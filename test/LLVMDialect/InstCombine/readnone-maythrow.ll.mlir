module  {
  llvm.func @readnone_but_may_throw()
  llvm.func @f_0(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    llvm.store %1, %arg0 : !llvm.ptr<i32>
    llvm.call @readnone_but_may_throw() : () -> ()
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @f_1(%arg0: i1, %arg1: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    llvm.store %1, %arg1 : !llvm.ptr<i32>
    llvm.call @readnone_but_may_throw() : () -> ()
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %0, %arg1 : !llvm.ptr<i32>
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }
}
