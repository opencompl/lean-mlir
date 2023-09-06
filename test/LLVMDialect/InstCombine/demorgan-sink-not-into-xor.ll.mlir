module  {
  llvm.func @gen1() -> i1
  llvm.func @positive_easyinvert(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.icmp "slt" %arg0, %2 : i16
    %4 = llvm.icmp "slt" %arg1, %1 : i8
    %5 = llvm.xor %4, %3  : i1
    %6 = llvm.xor %5, %0  : i1
    llvm.return %6 : i1
  }
  llvm.func @positive_easyinvert0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %1 : i8
    %4 = llvm.xor %3, %2  : i1
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }
  llvm.func @positive_easyinvert1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %1 : i8
    %4 = llvm.xor %2, %3  : i1
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }
  llvm.func @use1(i1)
  llvm.func @oneuse_easyinvert_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }
  llvm.func @oneuse_easyinvert_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %1 : i8
    %4 = llvm.xor %2, %3  : i1
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }
  llvm.func @oneuse_easyinvert_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }
  llvm.func @negative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }
}
