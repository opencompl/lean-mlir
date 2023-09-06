module  {
  llvm.func @f(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.icmp "sgt" %arg0, %3 : i32
    llvm.call @llvm.assume(%4) : (i1) -> ()
    llvm.cond_br %2, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %5 = llvm.shl %arg0, %0  : i32
    llvm.br ^bb2(%5 : i32)
  ^bb2(%6: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %6 : i32
  }
  llvm.func @llvm.assume(i1)
}
