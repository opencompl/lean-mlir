module  {
  llvm.func @without_range(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.load %arg0 : !llvm.ptr<i32>
    %3 = llvm.sdiv %2, %1  : i32
    %4 = llvm.icmp "sge" %0, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @with_range(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.load %arg0 : !llvm.ptr<i32>
    %3 = llvm.sdiv %2, %1  : i32
    %4 = llvm.icmp "sge" %0, %3 : i32
    llvm.return %4 : i1
  }
}
