module  {
  llvm.func @test(%arg0: !llvm.ptr<i32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.load %arg0 : !llvm.ptr<i32>
    %4 = llvm.bitcast %3 : i32 to i32
    %5 = llvm.lshr %4, %2  : i32
    %6 = llvm.bitcast %5 : i32 to i32
    %7 = llvm.and %6, %1  : i32
    %8 = llvm.icmp "ne" %7, %0 : i32
    %9 = llvm.zext %8 : i1 to i32
    llvm.return %9 : i32
  }
}
