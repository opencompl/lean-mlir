module  {
  llvm.mlir.global internal @Q(1.000000e+00 : f64) : f64
  llvm.func @test(%arg0: i1, %arg1: !llvm.ptr<i64>) -> f64 {
    %0 = llvm.mlir.addressof @Q : !llvm.ptr<f64>
    %1 = llvm.bitcast %0 : !llvm.ptr<f64> to !llvm.ptr<i64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%2 : i64)
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %1 : !llvm.ptr<i64>
    llvm.br ^bb2(%3 : i64)
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    llvm.store %4, %arg1 : !llvm.ptr<i64>
    %5 = llvm.bitcast %4 : i64 to f64
    llvm.return %5 : f64
  }
}
