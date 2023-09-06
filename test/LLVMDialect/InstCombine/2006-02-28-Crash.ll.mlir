module  {
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }
}
