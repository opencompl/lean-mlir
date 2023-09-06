module  {
  llvm.func @foo(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(1648 : i32) : i32
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(63 : i64) : i64
    %5 = llvm.ptrtoint %arg0 : !llvm.ptr<i32> to i64
    %6 = llvm.and %5, %4  : i64
    %7 = llvm.icmp "eq" %6, %3 : i64
    llvm.call @llvm.assume(%7) : (i1) -> ()
    %8 = llvm.ptrtoint %arg1 : !llvm.ptr<i32> to i64
    %9 = llvm.and %8, %4  : i64
    %10 = llvm.icmp "eq" %9, %3 : i64
    llvm.call @llvm.assume(%10) : (i1) -> ()
    llvm.br ^bb1(%3 : i64)
  ^bb1(%11: i64):  // 2 preds: ^bb0, ^bb1
    %12 = llvm.getelementptr %arg1[%11] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %13 = llvm.load %12 : !llvm.ptr<i32>
    %14 = llvm.add %13, %2  : i32
    %15 = llvm.getelementptr %arg0[%11] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %14, %15 : !llvm.ptr<i32>
    %16 = llvm.add %11, %1  : i64
    %17 = llvm.trunc %16 : i64 to i32
    %18 = llvm.icmp "slt" %17, %0 : i32
    llvm.cond_br %18, ^bb1(%16 : i64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @llvm.assume(i1)
}
