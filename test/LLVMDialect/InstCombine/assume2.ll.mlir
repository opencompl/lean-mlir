module  {
  llvm.func @llvm.assume(i1)
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.call @llvm.assume(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-11 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(15 : i32) : i32
    %4 = llvm.and %arg0, %3  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.call @llvm.assume(%6) : (i1) -> ()
    %7 = llvm.and %arg0, %0  : i32
    llvm.return %7 : i32
  }
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-11 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.call @llvm.assume(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(-16 : i32) : i32
    %4 = llvm.or %arg0, %3  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.call @llvm.assume(%6) : (i1) -> ()
    %7 = llvm.and %arg0, %0  : i32
    llvm.return %7 : i32
  }
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.xor %arg0, %2  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.call @llvm.assume(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.shl %arg0, %2  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.call @llvm.assume(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @test7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(252 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.call @llvm.assume(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @test8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(252 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.call @llvm.assume(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @test9(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %1 : i32
    llvm.call @llvm.assume(%2) : (i1) -> ()
    %3 = llvm.and %arg0, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %1 : i32
    llvm.call @llvm.assume(%2) : (i1) -> ()
    %3 = llvm.and %arg0, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3072 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.icmp "ule" %arg0, %1 : i32
    llvm.call @llvm.assume(%2) : (i1) -> ()
    %3 = llvm.and %arg0, %0  : i32
    llvm.return %3 : i32
  }
}
