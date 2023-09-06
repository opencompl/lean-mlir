module  {
  llvm.func @llvm.bitreverse.i8(i8) -> i8
  llvm.func @llvm.bitreverse.i32(i32) -> i32
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.call @llvm.bitreverse.i32(%2) : (i32) -> i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    llvm.return %5 : i1
  }
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.call @llvm.bitreverse.i32(%2) : (i32) -> i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.call @llvm.bitreverse.i32(%4) : (i32) -> i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.return %6 : i1
  }
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32768 : i32) : i32
    %2 = llvm.mlir.constant(65536 : i32) : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.call @llvm.bitreverse.i32(%3) : (i32) -> i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %0 : i32
    llvm.return %6 : i1
  }
  llvm.func @add_bitreverse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.call @llvm.bitreverse.i8(%2) : (i8) -> i8
    %4 = llvm.add %3, %0  : i8
    llvm.return %4 : i8
  }
}
