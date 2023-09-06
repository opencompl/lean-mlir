module  {
  llvm.func @llvm.assume(i1)
  llvm.func @f1(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.getelementptr %arg0[%5] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %7 = llvm.ptrtoint %6 : !llvm.ptr<i8> to i64
    %8 = llvm.and %7, %4  : i64
    %9 = llvm.icmp "eq" %8, %3 : i64
    llvm.cond_br %9, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.call @llvm.assume(%2) : (i1) -> ()
    %10 = llvm.ptrtoint %6 : !llvm.ptr<i8> to i64
    %11 = llvm.and %10, %4  : i64
    %12 = llvm.icmp "eq" %11, %3 : i64
    llvm.cond_br %12, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %13 = llvm.bitcast %6 : !llvm.ptr<i8> to !llvm.ptr<i32>
    llvm.store %1, %13 : !llvm.ptr<i32>
    llvm.br ^bb4
  ^bb3:  // pred: ^bb1
    llvm.store %0, %6 : !llvm.ptr<i8>
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return
  }
  llvm.func @f2(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(15 : i64) : i64
    %4 = llvm.mlir.constant(8 : i64) : i64
    %5 = llvm.mlir.constant(true) : i1
    llvm.call @llvm.assume(%5) : (i1) -> ()
    %6 = llvm.getelementptr %arg0[%4] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %7 = llvm.ptrtoint %6 : !llvm.ptr<i8> to i64
    %8 = llvm.and %7, %3  : i64
    %9 = llvm.icmp "eq" %8, %2 : i64
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %10 = llvm.bitcast %6 : !llvm.ptr<i8> to !llvm.ptr<i64>
    llvm.store %1, %10 : !llvm.ptr<i64>
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %0, %6 : !llvm.ptr<i8>
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return
  }
  llvm.func @f3(%arg0: i64, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr<i8> to i64
    llvm.call @llvm.assume(%0) : (i1) -> ()
    %2 = llvm.add %arg0, %1  : i64
    llvm.call @g(%2) : (i64) -> ()
    llvm.return
  }
  llvm.func @g(i64)
  llvm.func @assume_align_zero(%arg0: !llvm.ptr<i8>) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.call @llvm.assume(%0) : (i1) -> ()
    %1 = llvm.load %arg0 : !llvm.ptr<i8>
    llvm.return %1 : i8
  }
  llvm.func @assume_align_non_pow2(%arg0: !llvm.ptr<i8>) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.call @llvm.assume(%0) : (i1) -> ()
    %1 = llvm.load %arg0 : !llvm.ptr<i8>
    llvm.return %1 : i8
  }
}
