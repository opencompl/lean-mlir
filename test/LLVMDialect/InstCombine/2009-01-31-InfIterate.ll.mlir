module  {
  llvm.func @test(%arg0: i64, %arg1: i64, %arg2: i1, %arg3: i128, %arg4: i128, %arg5: !llvm.ptr<i64>, %arg6: !llvm.ptr<i64>) -> i128 {
    %0 = llvm.trunc %arg3 : i128 to i64
    %1 = llvm.trunc %arg4 : i128 to i64
    llvm.store %0, %arg5 : !llvm.ptr<i64>
    llvm.store %1, %arg6 : !llvm.ptr<i64>
    %2 = llvm.sub %0, %1  : i64
    %3 = llvm.sub %0, %1  : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.sub %3, %4  : i64
    llvm.br ^bb1(%5 : i64)
  ^bb1(%6: i64):  // 2 preds: ^bb0, ^bb2
    %7 = llvm.zext %6 : i64 to i128
    llvm.return %7 : i128
  ^bb2:  // no predecessors
    llvm.br ^bb1(%0 : i64)
  }
}
