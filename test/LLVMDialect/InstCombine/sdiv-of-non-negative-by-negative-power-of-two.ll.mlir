module  {
  llvm.func @llvm.assume(i1)
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "sge" %arg0, %1 : i8
    llvm.call @llvm.assume(%2) : (i1) -> ()
    %3 = llvm.sdiv %arg0, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @n1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "sge" %arg0, %1 : i8
    llvm.call @llvm.assume(%2) : (i1) -> ()
    %3 = llvm.sdiv %arg0, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-31 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "sge" %arg0, %1 : i8
    llvm.call @llvm.assume(%2) : (i1) -> ()
    %3 = llvm.sdiv %arg0, %0  : i8
    llvm.return %3 : i8
  }
}
