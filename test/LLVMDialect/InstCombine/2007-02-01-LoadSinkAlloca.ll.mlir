module  {
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i32 : (i32) -> !llvm.ptr<i32>
    %4 = llvm.alloca %2 x i32 : (i32) -> !llvm.ptr<i32>
    %5 = llvm.call @bar(%3) : (!llvm.ptr<i32>) -> i32
    %6 = llvm.load %3 : !llvm.ptr<i32>
    %7 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.cond_br %7, ^bb2(%6 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.store %0, %4 : !llvm.ptr<i32>
    %8 = llvm.call @test2(%0) : (i32) -> i32
    %9 = llvm.load %4 : !llvm.ptr<i32>
    llvm.br ^bb2(%9 : i32)
  ^bb2(%10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.call @baq() : () -> i32
    %12 = llvm.call @baq() : () -> i32
    %13 = llvm.call @baq() : () -> i32
    %14 = llvm.call @baq() : () -> i32
    %15 = llvm.call @baq() : () -> i32
    %16 = llvm.call @baq() : () -> i32
    %17 = llvm.call @baq() : () -> i32
    %18 = llvm.call @baq() : () -> i32
    %19 = llvm.call @baq() : () -> i32
    %20 = llvm.call @baq() : () -> i32
    %21 = llvm.call @baq() : () -> i32
    %22 = llvm.call @baq() : () -> i32
    %23 = llvm.call @baq() : () -> i32
    %24 = llvm.call @baq() : () -> i32
    llvm.return %10 : i32
  }
  llvm.func @bar(...) -> i32
  llvm.func @baq(...) -> i32
}
