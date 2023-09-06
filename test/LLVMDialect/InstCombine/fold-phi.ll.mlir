module  {
  llvm.func @no_crash(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    llvm.br ^bb1(%0 : f32)
  ^bb1(%1: f32):  // 2 preds: ^bb0, ^bb2
    %2 = llvm.fadd %1, %arg0  : f32
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb1(%2 : f32)
  ^bb3:  // pred: ^bb1
    llvm.return %2 : f32
  }
  llvm.func @pr21377(%arg0: i32, %arg1: i1) {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.undef : i64
    llvm.br ^bb1(%1 : i64)
  ^bb1(%2: i64):  // 2 preds: ^bb0, ^bb3
    %3 = llvm.zext %arg0 : i32 to i64
    llvm.cond_br %arg1, ^bb3(%1 : i64), ^bb2
  ^bb2:  // pred: ^bb1
    %4 = llvm.or %2, %3  : i64
    %5 = llvm.and %4, %0  : i64
    llvm.br ^bb3(%5 : i64)
  ^bb3(%6: i64):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.or %6, %3  : i64
    llvm.br ^bb1(%7 : i64)
  }
}
