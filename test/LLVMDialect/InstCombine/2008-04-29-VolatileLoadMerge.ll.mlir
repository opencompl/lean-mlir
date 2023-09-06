module  {
  llvm.mlir.global internal @g_1(0 : i32) : i32
  llvm.func @main(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @g_1 : !llvm.ptr<i32>
    %1 = llvm.mlir.addressof @g_1 : !llvm.ptr<i32>
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    %4 = llvm.load %1 : !llvm.ptr<i32>
    llvm.cond_br %3, ^bb2(%4 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load %0 : !llvm.ptr<i32>
    llvm.br ^bb2(%5 : i32)
  ^bb2(%6: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %6 : i32
  }
}
