module  {
  llvm.func @hash_string(%arg0: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(16383 : i32) : i32
    %2 = llvm.mlir.constant(14 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(0 : i8) : i8
    %7 = llvm.load %arg0 : !llvm.ptr<i8>
    %8 = llvm.icmp "eq" %7, %6 : i8
    llvm.cond_br %8, ^bb2(%5 : i32), ^bb1(%4, %5 : i64, i32)
  ^bb1(%9: i64, %10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.getelementptr %arg0[%9] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %12 = llvm.shl %10, %3  : i32
    %13 = llvm.lshr %10, %2  : i32
    %14 = llvm.add %12, %13  : i32
    %15 = llvm.load %11 : !llvm.ptr<i8>
    %16 = llvm.sext %15 : i8 to i32
    %17 = llvm.xor %16, %14  : i32
    %18 = llvm.and %17, %1  : i32
    %19 = llvm.add %9, %0  : i64
    %20 = llvm.getelementptr %arg0[%19] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %21 = llvm.load %20 : !llvm.ptr<i8>
    %22 = llvm.icmp "eq" %21, %6 : i8
    llvm.cond_br %22, ^bb2(%18 : i32), ^bb1(%19, %18 : i64, i32)
  ^bb2(%23: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %23 : i32
  }
}
