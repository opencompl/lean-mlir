module  {
  llvm.func @mysqrt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x f64 : (i32) -> !llvm.ptr<f64>
    %4 = llvm.alloca %2 x f64 : (i32) -> !llvm.ptr<f64>
    %5 = llvm.alloca %2 x f64 : (i32) -> !llvm.ptr<f64>
    %6 = llvm.bitcast %1 : i32 to i32
    llvm.store %arg0, %3 : !llvm.ptr<f64>
    %7 = llvm.load %3 : !llvm.ptr<f64>
    %8 = llvm.call @fabs(%7) : (f64) -> f64
    %9 = llvm.call @sqrt(%8) : (f64) -> f64
    %10 = llvm.fadd %9, %0  : f64
    llvm.store %10, %5 : !llvm.ptr<f64>
    %11 = llvm.load %5 : !llvm.ptr<f64>
    llvm.store %11, %4 : !llvm.ptr<f64>
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %12 = llvm.load %4 : !llvm.ptr<f64>
    llvm.return %12 : f64
  }
  llvm.func @fabs(f64) -> f64
  llvm.func @sqrt(f64) -> f64
}
