module  {
  llvm.func @llvm.assume(i1)
  llvm.func @gen8() -> i8
  llvm.func @use8(i8)
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    llvm.call @llvm.assume(%1) : (i1) -> ()
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    llvm.call @llvm.assume(%1) : (i1) -> ()
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "uge" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @t2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @llvm.assume(%1) : (i1) -> ()
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ugt" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @t3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @llvm.assume(%1) : (i1) -> ()
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ule" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @n4_maybezero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @n5_wrongnonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.call @llvm.assume(%1) : (i1) -> ()
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }
}
