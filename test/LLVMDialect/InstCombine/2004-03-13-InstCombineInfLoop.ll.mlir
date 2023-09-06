module  {
  llvm.func @test(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.bitcast %1 : i32 to i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.icmp "eq" %2, %3 : i32
    llvm.return %4 : i1
  }
}
