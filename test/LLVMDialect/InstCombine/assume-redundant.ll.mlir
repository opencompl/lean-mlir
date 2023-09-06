module  {
  llvm.func @_Z3fooR1s(%arg0: !llvm.ptr<struct<"struct.s", (ptr<f64>)>>) {
    %0 = llvm.mlir.constant(1599 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(31 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.getelementptr %arg0[%6, %5] : (!llvm.ptr<struct<"struct.s", (ptr<f64>)>>, i64, i32) -> !llvm.ptr<ptr<f64>>
    %8 = llvm.load %7 : !llvm.ptr<ptr<f64>>
    %9 = llvm.ptrtoint %8 : !llvm.ptr<f64> to i64
    %10 = llvm.and %9, %4  : i64
    %11 = llvm.icmp "eq" %10, %6 : i64
    llvm.br ^bb1(%6 : i64)
  ^bb1(%12: i64):  // 2 preds: ^bb0, ^bb1
    llvm.call @llvm.assume(%11) : (i1) -> ()
    %13 = llvm.getelementptr %8[%12] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %14 = llvm.load %13 : !llvm.ptr<f64>
    %15 = llvm.fadd %14, %3  : f64
    llvm.call @llvm.assume(%11) : (i1) -> ()
    %16 = llvm.fmul %15, %2  : f64
    llvm.store %16, %13 : !llvm.ptr<f64>
    %17 = llvm.add %12, %1  : i64
    llvm.call @llvm.assume(%11) : (i1) -> ()
    %18 = llvm.getelementptr %8[%17] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %19 = llvm.load %18 : !llvm.ptr<f64>
    %20 = llvm.fadd %19, %3  : f64
    llvm.call @llvm.assume(%11) : (i1) -> ()
    %21 = llvm.fmul %20, %2  : f64
    llvm.store %21, %18 : !llvm.ptr<f64>
    %22 = llvm.add %17, %1  : i64
    %23 = llvm.icmp "eq" %17, %0 : i64
    llvm.cond_br %23, ^bb2, ^bb1(%22 : i64)
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @get() -> !llvm.ptr<i8>
  llvm.func @test1() {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.call @get() : () -> !llvm.ptr<i8>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<i8> to i64
    %4 = llvm.and %3, %1  : i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    llvm.call @llvm.assume(%5) : (i1) -> ()
    llvm.return
  }
  llvm.func @test3() {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i8 : (i32) -> !llvm.ptr<i8>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i8> to i64
    %5 = llvm.and %4, %1  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.call @llvm.assume(%6) : (i1) -> ()
    llvm.return
  }
  llvm.func @llvm.assume(i1)
}
