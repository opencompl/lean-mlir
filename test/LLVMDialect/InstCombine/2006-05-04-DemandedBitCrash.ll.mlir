module  {
  llvm.func @test() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(63 : i32) : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.constant(10 : i32) : i32
    %6 = llvm.mlir.constant(false) : i1
    %7 = llvm.mlir.constant(31 : i32) : i32
    %8 = llvm.mlir.constant(29 : i32) : i32
    %9 = llvm.mlir.constant(16 : i64) : i64
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.mlir.constant(123814269237067777 : i64) : i64
    %12 = llvm.bitcast %11 : i64 to i64
    %13 = llvm.bitcast %10 : i32 to i32
    %14 = llvm.lshr %12, %9  : i64
    %15 = llvm.trunc %14 : i64 to i32
    %16 = llvm.lshr %15, %8  : i32
    %17 = llvm.and %16, %10  : i32
    %18 = llvm.lshr %15, %7  : i32
    %19 = llvm.trunc %18 : i32 to i8
    llvm.cond_br %6, ^bb6, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %6, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    %20 = llvm.lshr %13, %5  : i32
    %21 = llvm.lshr %13, %4  : i32
    %22 = llvm.and %21, %3  : i32
    %23 = llvm.icmp "ult" %22, %4 : i32
    %24 = llvm.icmp "eq" %17, %2 : i32
    %25 = llvm.or %23, %6  : i1
    %26 = llvm.or %25, %6  : i1
    %27 = llvm.or %26, %6  : i1
    %28 = llvm.or %27, %24  : i1
    llvm.cond_br %6, ^bb3, ^bb5(%18 : i32)
  ^bb3:  // pred: ^bb2
    llvm.cond_br %6, ^bb4, ^bb5(%2 : i32)
  ^bb4:  // pred: ^bb3
    llvm.br ^bb7
  ^bb5(%29: i32):  // 2 preds: ^bb2, ^bb3
    %30 = llvm.and %20, %1  : i32
    llvm.br ^bb7
  ^bb6:  // 2 preds: ^bb0, ^bb1
    %31 = llvm.icmp "eq" %17, %2 : i32
    %32 = llvm.icmp "eq" %19, %0 : i8
    %33 = llvm.or %31, %32  : i1
    %34 = llvm.or %33, %6  : i1
    llvm.br ^bb7
  ^bb7:  // 3 preds: ^bb4, ^bb5, ^bb6
    llvm.return
  }
}
