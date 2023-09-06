module  {
  llvm.func @a(%arg0: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %1, %arg0 : !llvm.ptr<i8>
    %2 = llvm.call @strlen(%arg0) : (!llvm.ptr<i8>) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %1, %arg0 : !llvm.ptr<i8>
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }
  llvm.func @strlen(!llvm.ptr<i8>) -> i32
}
