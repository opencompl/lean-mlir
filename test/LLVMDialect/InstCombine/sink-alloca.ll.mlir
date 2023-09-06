module  {
  llvm.func @cond() -> i1
  llvm.func @use_and_return(!llvm.ptr<i32>) -> !llvm.ptr<i32>
  llvm.func @llvm.stacksave() -> !llvm.ptr<i8>
  llvm.func @llvm.stackrestore(!llvm.ptr<i8>)
  llvm.func @foo(%arg0: i32) {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.call @cond() : () -> i1
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.alloca %arg0 x i32 : (i32) -> !llvm.ptr<i32>
    %3 = llvm.call @llvm.stacksave() : () -> !llvm.ptr<i8>
    %4 = llvm.call @cond() : () -> i1
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %5 = llvm.call @use_and_return(%2) : (!llvm.ptr<i32>) -> !llvm.ptr<i32>
    llvm.store %0, %5 : !llvm.ptr<i32>
    llvm.call @llvm.stackrestore(%3) : (!llvm.ptr<i8>) -> ()
    %6 = llvm.call @use_and_return(%5) : (!llvm.ptr<i32>) -> !llvm.ptr<i32>
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }
}
