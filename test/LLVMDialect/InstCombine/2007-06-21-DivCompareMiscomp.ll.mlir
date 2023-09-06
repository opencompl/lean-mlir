module  {
  llvm.func @test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %1  : i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    llvm.return %3 : i1
  }
}
