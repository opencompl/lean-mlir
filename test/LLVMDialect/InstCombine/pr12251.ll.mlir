module  {
  llvm.func @_Z3fooPb(%arg0: !llvm.ptr<i8>) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.load %arg0 : !llvm.ptr<i8>
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    llvm.return %4 : i1
  }
}
