module  {
  llvm.func @av_cmp_q_cond_true(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>, %arg2: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(63 : i32) : i32
    llvm.br ^bb2
  ^bb1:  // pred: ^bb2
    llvm.return
  ^bb2:  // pred: ^bb0
    %2 = llvm.load %arg2 : !llvm.ptr<i64>
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.ashr %2, %3  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.or %5, %0  : i32
    llvm.store %6, %arg1 : !llvm.ptr<i32>
    %7 = llvm.load %arg1 : !llvm.ptr<i32>
    llvm.store %7, %arg0 : !llvm.ptr<i32>
    llvm.br ^bb1
  }
}
