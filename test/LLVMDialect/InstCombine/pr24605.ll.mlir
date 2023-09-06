module  {
  llvm.func @f(%arg0: !llvm.ptr<i8>, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-117 : i8) : i8
    %2 = llvm.or %arg1, %1  : i8
    %3 = llvm.add %2, %0  : i8
    llvm.store %3, %arg0 : !llvm.ptr<i8>
    %4 = llvm.icmp "ugt" %2, %3 : i8
    llvm.return %4 : i1
  }
}
