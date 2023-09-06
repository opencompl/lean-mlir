module  {
  llvm.func internal @ScaleObjectAdd(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(640 : i960) : i960
    %1 = llvm.mlir.constant(320 : i960) : i960
    %2 = llvm.bitcast %arg0 : f64 to i64
    %3 = llvm.zext %2 : i64 to i960
    %4 = llvm.bitcast %arg1 : f64 to i64
    %5 = llvm.zext %4 : i64 to i960
    %6 = llvm.shl %5, %1  : i960
    %7 = llvm.or %3, %6  : i960
    %8 = llvm.bitcast %arg2 : f64 to i64
    %9 = llvm.zext %8 : i64 to i960
    %10 = llvm.shl %9, %0  : i960
    %11 = llvm.or %7, %10  : i960
    %12 = llvm.trunc %11 : i960 to i64
    %13 = llvm.bitcast %12 : i64 to f64
    %14 = llvm.lshr %11, %1  : i960
    %15 = llvm.trunc %14 : i960 to i64
    %16 = llvm.bitcast %15 : i64 to f64
    %17 = llvm.fadd %13, %16  : f64
    llvm.return %16 : f64
  }
}
