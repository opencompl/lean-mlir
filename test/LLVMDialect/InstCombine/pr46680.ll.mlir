module  {
  llvm.mlir.global external @a(0 : i64) : i64
  llvm.mlir.global external @d(0 : i64) : i64
  llvm.mlir.global external @c() : i8
  llvm.func @test(%arg0: !llvm.ptr<i16>) {
    %0 = llvm.mlir.addressof @c : !llvm.ptr<i8>
    %1 = llvm.mlir.addressof @c : !llvm.ptr<i8>
    %2 = llvm.mlir.addressof @c : !llvm.ptr<i8>
    %3 = llvm.mlir.addressof @c : !llvm.ptr<i8>
    %4 = llvm.mlir.addressof @c : !llvm.ptr<i8>
    %5 = llvm.mlir.addressof @c : !llvm.ptr<i8>
    %6 = llvm.mlir.addressof @c : !llvm.ptr<i8>
    %7 = llvm.mlir.addressof @c : !llvm.ptr<i8>
    %8 = llvm.mlir.addressof @a : !llvm.ptr<i64>
    %9 = llvm.mlir.constant(0 : i64) : i64
    %10 = llvm.mlir.addressof @d : !llvm.ptr<i64>
    %11 = llvm.load %10 : !llvm.ptr<i64>
    %12 = llvm.icmp "eq" %11, %9 : i64
    %13 = llvm.load %8 : !llvm.ptr<i64>
    %14 = llvm.icmp "ne" %13, %9 : i64
    llvm.cond_br %12, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %15 = llvm.load %arg0 : !llvm.ptr<i16>
    %16 = llvm.trunc %15 : i16 to i8
    llvm.store %16, %7 : !llvm.ptr<i8>
    llvm.call @llvm.assume(%14) : (i1) -> ()
    %17 = llvm.load %arg0 : !llvm.ptr<i16>
    %18 = llvm.trunc %17 : i16 to i8
    llvm.store %18, %6 : !llvm.ptr<i8>
    %19 = llvm.load %arg0 : !llvm.ptr<i16>
    %20 = llvm.trunc %19 : i16 to i8
    llvm.store %20, %5 : !llvm.ptr<i8>
    %21 = llvm.load %arg0 : !llvm.ptr<i16>
    %22 = llvm.trunc %21 : i16 to i8
    llvm.store %22, %4 : !llvm.ptr<i8>
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    %23 = llvm.load %arg0 : !llvm.ptr<i16>
    %24 = llvm.trunc %23 : i16 to i8
    llvm.store %24, %3 : !llvm.ptr<i8>
    %25 = llvm.load %arg0 : !llvm.ptr<i16>
    %26 = llvm.trunc %25 : i16 to i8
    llvm.store %26, %2 : !llvm.ptr<i8>
    %27 = llvm.load %arg0 : !llvm.ptr<i16>
    %28 = llvm.trunc %27 : i16 to i8
    llvm.store %28, %1 : !llvm.ptr<i8>
    %29 = llvm.load %arg0 : !llvm.ptr<i16>
    %30 = llvm.trunc %29 : i16 to i8
    llvm.store %30, %0 : !llvm.ptr<i8>
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb3, ^bb4
    llvm.br ^bb4
  }
  llvm.func @llvm.assume(i1)
}
