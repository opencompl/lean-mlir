module  {
  llvm.func @test(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>, %arg2: i32, %arg3: i32, %arg4: !llvm.ptr<i32>, %arg5: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.and %arg2, %6  : i32
    %8 = llvm.shl %7, %5  : i32
    %9 = llvm.ashr %arg2, %6  : i32
    %10 = llvm.shl %9, %5  : i32
    %11 = llvm.ashr %8, %4  : i32
    llvm.store %11, %arg0 : !llvm.ptr<i32>
    %12 = llvm.ashr %10, %4  : i32
    llvm.store %12, %arg1 : !llvm.ptr<i32>
    %13 = llvm.icmp "eq" %arg3, %3 : i32
    %14 = llvm.zext %13 : i1 to i8
    %15 = llvm.icmp "ne" %14, %2 : i8
    llvm.cond_br %15, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %8, %arg4 : !llvm.ptr<i32>
    llvm.store %10, %arg5 : !llvm.ptr<i32>
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.store %8, %arg4 : !llvm.ptr<i32>
    llvm.store %10, %arg5 : !llvm.ptr<i32>
    llvm.return %0 : i1
  }
}
