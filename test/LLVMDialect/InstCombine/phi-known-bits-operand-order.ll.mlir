module  {
  llvm.func @cond() -> i1
  llvm.func @phi_recurrence_start_first() {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%2 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb4
    %4 = llvm.call @cond() : () -> i1
    llvm.cond_br %4, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %5 = llvm.add %3, %1  : i32
    llvm.cond_br %4, ^bb3(%5 : i32), ^bb4
  ^bb3(%6: i32):  // 2 preds: ^bb2, ^bb3
    %7 = llvm.icmp "sle" %6, %0 : i32
    %8 = llvm.add %6, %1  : i32
    llvm.cond_br %7, ^bb3(%8 : i32), ^bb5
  ^bb4:  // pred: ^bb2
    llvm.br ^bb1(%5 : i32)
  ^bb5:  // 2 preds: ^bb1, ^bb3
    llvm.return
  }
  llvm.func @phi_recurrence_step_first() {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%2 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb4
    %4 = llvm.call @cond() : () -> i1
    llvm.cond_br %4, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %5 = llvm.add %3, %1  : i32
    llvm.cond_br %4, ^bb3(%5 : i32), ^bb4
  ^bb3(%6: i32):  // 2 preds: ^bb2, ^bb3
    %7 = llvm.icmp "sle" %6, %0 : i32
    %8 = llvm.add %6, %1  : i32
    llvm.cond_br %7, ^bb3(%8 : i32), ^bb5
  ^bb4:  // pred: ^bb2
    llvm.br ^bb1(%5 : i32)
  ^bb5:  // 2 preds: ^bb1, ^bb3
    llvm.return
  }
}
