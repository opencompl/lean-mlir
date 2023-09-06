module  {
  llvm.func @matching_phi(%arg0: i64, %arg1: !llvm.ptr<f32>, %arg2: i1) {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.icmp "eq" %arg2, %4 : i1
    %6 = llvm.add %arg0, %3  : i64
    %7 = llvm.inttoptr %6 : i64 to !llvm.ptr<f32>
    %8 = llvm.getelementptr %arg1[%2] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %9 = llvm.ptrtoint %8 : !llvm.ptr<f32> to i64
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%8, %9 : !llvm.ptr<f32>, i64)
  ^bb2:  // pred: ^bb0
    llvm.store %1, %7 : !llvm.ptr<f32>
    llvm.br ^bb3(%7, %6 : !llvm.ptr<f32>, i64)
  ^bb3(%10: !llvm.ptr<f32>, %11: i64):  // 2 preds: ^bb1, ^bb2
    %12 = llvm.inttoptr %11 : i64 to !llvm.ptr<f32>
    %13 = llvm.load %12 : !llvm.ptr<f32>
    %14 = llvm.fmul %13, %0  : f32
    llvm.store %14, %10 : !llvm.ptr<f32>
    llvm.return
  }
  llvm.func @no_matching_phi(%arg0: i64, %arg1: !llvm.ptr<f32>, %arg2: i1) {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.icmp "eq" %arg2, %4 : i1
    %6 = llvm.add %arg0, %3  : i64
    %7 = llvm.inttoptr %6 : i64 to !llvm.ptr<f32>
    %8 = llvm.getelementptr %arg1[%2] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %9 = llvm.ptrtoint %8 : !llvm.ptr<f32> to i64
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%8, %6 : !llvm.ptr<f32>, i64)
  ^bb2:  // pred: ^bb0
    llvm.store %1, %7 : !llvm.ptr<f32>
    llvm.br ^bb3(%7, %9 : !llvm.ptr<f32>, i64)
  ^bb3(%10: !llvm.ptr<f32>, %11: i64):  // 2 preds: ^bb1, ^bb2
    %12 = llvm.inttoptr %11 : i64 to !llvm.ptr<f32>
    %13 = llvm.load %12 : !llvm.ptr<f32>
    %14 = llvm.fmul %13, %0  : f32
    llvm.store %14, %10 : !llvm.ptr<f32>
    llvm.return
  }
}
