module  {
  llvm.func @test() {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(37 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%3, %2 : i32, i32)
  ^bb1(%4: i32, %5: i32):  // 2 preds: ^bb0, ^bb6
    %6 = llvm.call @bork() : () -> i32
    %7 = llvm.call @bork() : () -> i32
    %8 = llvm.call @bork() : () -> i32
    %9 = llvm.icmp "eq" %8, %3 : i32
    llvm.cond_br %9, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %10 = llvm.call @bork() : () -> i32
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %11 = llvm.call @bork() : () -> i32
    %12 = llvm.call @bork() : () -> i32
    %13 = llvm.icmp "eq" %5, %2 : i32
    llvm.cond_br %13, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %14 = llvm.call @bar() : () -> i32
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %15 = llvm.call @zap() : () -> i32
    %16 = llvm.add %4, %1  : i32
    %17 = llvm.icmp "eq" %16, %0 : i32
    llvm.cond_br %17, ^bb7, ^bb6
  ^bb6:  // pred: ^bb5
    llvm.br ^bb1(%16, %15 : i32, i32)
  ^bb7:  // pred: ^bb5
    llvm.return
  }
  llvm.func @bork(...) -> i32
  llvm.func @bar(...) -> i32
  llvm.func @zap(...) -> i32
}
