module  {
  llvm.func @test() -> i1 {
    %0 = llvm.mlir.constant(41 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
}
