module  {
  llvm.mlir.global internal @g_1(0 : i32) : i32
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.addressof @g_1 : !llvm.ptr<i32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.addressof @g_1 : !llvm.ptr<i32>
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.addressof @g_1 : !llvm.ptr<i32>
    %5 = llvm.mlir.constant(10 : i32) : i32
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.icmp "slt" %6, %5 : i32
    %8 = llvm.load %4 : !llvm.ptr<i32>
    llvm.br ^bb1(%6, %8 : i32, i32)
  ^bb1(%9: i32, %10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.add %10, %3  : i32
    llvm.store %11, %2 : !llvm.ptr<i32>
    %12 = llvm.add %9, %1  : i32
    %13 = llvm.icmp "slt" %12, %5 : i32
    %14 = llvm.load %0 : !llvm.ptr<i32>
    llvm.cond_br %13, ^bb1(%12, %14 : i32, i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %6 : i32
  }
}
