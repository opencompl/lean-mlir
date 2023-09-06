module  {
  llvm.func @llvm.bswap.i16(i16) -> i16
  llvm.func @llvm.bswap.i32(i32) -> i32
  llvm.func @test1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(256 : i16) : i16
    %1 = llvm.mlir.constant(511 : i16) : i16
    %2 = llvm.or %arg0, %1  : i16
    %3 = llvm.call @llvm.bswap.i16(%2) : (i16) -> i16
    %4 = llvm.and %3, %0  : i16
    %5 = llvm.icmp "eq" %4, %0 : i16
    llvm.return %5 : i1
  }
  llvm.func @test2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(256 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.or %arg0, %1  : i16
    %3 = llvm.call @llvm.bswap.i16(%2) : (i16) -> i16
    %4 = llvm.and %3, %0  : i16
    %5 = llvm.icmp "eq" %4, %0 : i16
    llvm.return %5 : i1
  }
  llvm.func @test3(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.or %arg0, %1  : i16
    %3 = llvm.call @llvm.bswap.i16(%2) : (i16) -> i16
    %4 = llvm.and %3, %0  : i16
    %5 = llvm.icmp "eq" %4, %0 : i16
    llvm.return %5 : i1
  }
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.call @llvm.bswap.i32(%2) : (i32) -> i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    llvm.return %5 : i1
  }
}
