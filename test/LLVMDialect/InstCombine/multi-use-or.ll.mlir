module  {
  llvm.func @ScaleObjectAdd(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(128 : i192) : i192
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.zext %1 : i64 to i192
    %3 = llvm.bitcast %arg1 : f64 to i64
    %4 = llvm.zext %3 : i64 to i192
    %5 = llvm.shl %4, %0  : i192
    %6 = llvm.or %2, %5  : i192
    %7 = llvm.trunc %6 : i192 to i64
    %8 = llvm.bitcast %7 : i64 to f64
    %9 = llvm.lshr %6, %0  : i192
    %10 = llvm.trunc %9 : i192 to i64
    %11 = llvm.bitcast %10 : i64 to f64
    %12 = llvm.fadd %8, %11  : f64
    llvm.return %12 : f64
  }
}
