module  {
  llvm.func @oss_fuzz_32759(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(2147483647 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%3 : i32)
  ^bb1:  // pred: ^bb0
    %4 = llvm.zext %arg0 : i1 to i32
    %5 = llvm.shl %4, %2  : i32
    %6 = llvm.ashr %5, %2  : i32
    %7 = llvm.srem %6, %1  : i32
    %8 = llvm.xor %7, %6  : i32
    llvm.br ^bb2(%8 : i32)
  ^bb2(%9: i32):  // 2 preds: ^bb0, ^bb1
    %10 = llvm.icmp "eq" %9, %0 : i32
    llvm.return %10 : i1
  }
}
