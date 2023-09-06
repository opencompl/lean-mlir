module  {
  llvm.func @x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.sdiv %arg0, %1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }
}
