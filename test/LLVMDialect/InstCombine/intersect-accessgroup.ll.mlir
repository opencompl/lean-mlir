module  {
  llvm.func @arg(f64)
  llvm.func @func(%arg0: i64, %arg1: !llvm.ptr<f64>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%1 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb8
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.icmp "slt" %3, %arg0 : i64
    llvm.cond_br %4, ^bb2(%1 : i32), ^bb9
  ^bb2(%5: i32):  // 2 preds: ^bb1, ^bb7
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.icmp "slt" %6, %arg0 : i64
    llvm.cond_br %7, ^bb3(%1 : i32), ^bb8
  ^bb3(%8: i32):  // 2 preds: ^bb2, ^bb6
    %9 = llvm.sext %8 : i32 to i64
    %10 = llvm.icmp "slt" %9, %arg0 : i64
    llvm.cond_br %10, ^bb4(%1 : i32), ^bb7
  ^bb4(%11: i32):  // 2 preds: ^bb3, ^bb5
    %12 = llvm.sext %11 : i32 to i64
    %13 = llvm.icmp "slt" %12, %arg0 : i64
    llvm.cond_br %13, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    %14 = llvm.add %2, %5  : i32
    %15 = llvm.add %14, %8  : i32
    %16 = llvm.add %15, %11  : i32
    %17 = llvm.sext %16 : i32 to i64
    %18 = llvm.getelementptr %arg1[%17] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %19 = llvm.load %18 : !llvm.ptr<f64>
    %20 = llvm.load %18 : !llvm.ptr<f64>
    %21 = llvm.fadd %19, %20  : f64
    llvm.call @arg(%21) : (f64) -> ()
    %22 = llvm.add %11, %0  : i32
    llvm.br ^bb4(%22 : i32)
  ^bb6:  // pred: ^bb4
    %23 = llvm.add %8, %0  : i32
    llvm.br ^bb3(%23 : i32)
  ^bb7:  // pred: ^bb3
    %24 = llvm.add %5, %0  : i32
    llvm.br ^bb2(%24 : i32)
  ^bb8:  // pred: ^bb2
    %25 = llvm.add %2, %0  : i32
    llvm.br ^bb1(%25 : i32)
  ^bb9:  // pred: ^bb1
    llvm.return
  }
}
