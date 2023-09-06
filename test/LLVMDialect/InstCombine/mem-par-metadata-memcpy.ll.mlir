module  {
  llvm.func @_Z4testPcl(%arg0: !llvm.ptr<i8>, %arg1: i64) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    llvm.br ^bb1(%2 : i64)
  ^bb1(%3: i64):  // 2 preds: ^bb0, ^bb3
    %4 = llvm.icmp "slt" %3, %arg1 : i64
    llvm.cond_br %4, ^bb2, ^bb4
  ^bb2:  // pred: ^bb1
    %5 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %6 = llvm.add %3, %arg1  : i64
    %7 = llvm.getelementptr %arg0[%6] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%5, %7, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    %8 = llvm.add %3, %1  : i64
    llvm.br ^bb1(%8 : i64)
  ^bb4:  // pred: ^bb1
    llvm.return
  }
  llvm.func @llvm.memcpy.p0i8.p0i8.i64(!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1)
}
