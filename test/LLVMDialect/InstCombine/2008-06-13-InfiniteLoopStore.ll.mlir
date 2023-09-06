module  {
  llvm.mlir.global external @g_139(0 : i32) : i32
  llvm.func @func_56(%arg0: i32) {
    %0 = llvm.mlir.addressof @g_139 : !llvm.ptr<i32>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @g_139 : !llvm.ptr<i32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.store %4, %3 : !llvm.ptr<i32>
    %5 = llvm.icmp "ne" %arg0, %2 : i32
    %6 = llvm.zext %5 : i1 to i8
    %7 = llvm.icmp "ne" %6, %1 : i8
    llvm.cond_br %7, ^bb1, ^bb2
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.store %4, %0 : !llvm.ptr<i32>
    llvm.br ^bb1
  ^bb2:  // pred: ^bb0
    llvm.return
  }
}
