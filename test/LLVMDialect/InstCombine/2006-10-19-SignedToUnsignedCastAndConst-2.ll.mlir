module  {
  llvm.func @eq_signed_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
}
