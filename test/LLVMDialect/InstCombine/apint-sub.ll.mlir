module  {
  llvm.func @test1(%arg0: i23) -> i23 {
    %0 = llvm.sub %arg0, %arg0  : i23
    llvm.return %0 : i23
  }
  llvm.func @test2(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(0 : i47) : i47
    %1 = llvm.sub %arg0, %0  : i47
    llvm.return %1 : i47
  }
  llvm.func @test3(%arg0: i97) -> i97 {
    %0 = llvm.mlir.constant(0 : i97) : i97
    %1 = llvm.sub %0, %arg0  : i97
    %2 = llvm.sub %0, %1  : i97
    llvm.return %2 : i97
  }
  llvm.func @test4(%arg0: i108, %arg1: i108) -> i108 {
    %0 = llvm.mlir.constant(0 : i108) : i108
    %1 = llvm.sub %0, %arg0  : i108
    %2 = llvm.sub %arg1, %1  : i108
    llvm.return %2 : i108
  }
  llvm.func @test5(%arg0: i19, %arg1: i19, %arg2: i19) -> i19 {
    %0 = llvm.sub %arg1, %arg2  : i19
    %1 = llvm.sub %arg0, %0  : i19
    llvm.return %1 : i19
  }
  llvm.func @test6(%arg0: i57, %arg1: i57) -> i57 {
    %0 = llvm.and %arg0, %arg1  : i57
    %1 = llvm.sub %arg0, %0  : i57
    llvm.return %1 : i57
  }
  llvm.func @test7(%arg0: i77) -> i77 {
    %0 = llvm.mlir.constant(-1 : i77) : i77
    %1 = llvm.sub %0, %arg0  : i77
    llvm.return %1 : i77
  }
  llvm.func @test8(%arg0: i27) -> i27 {
    %0 = llvm.mlir.constant(9 : i27) : i27
    %1 = llvm.mul %0, %arg0  : i27
    %2 = llvm.sub %1, %arg0  : i27
    llvm.return %2 : i27
  }
  llvm.func @test9(%arg0: i42) -> i42 {
    %0 = llvm.mlir.constant(3 : i42) : i42
    %1 = llvm.mul %0, %arg0  : i42
    %2 = llvm.sub %arg0, %1  : i42
    llvm.return %2 : i42
  }
  llvm.func @test11(%arg0: i9, %arg1: i9) -> i1 {
    %0 = llvm.mlir.constant(0 : i9) : i9
    %1 = llvm.sub %arg0, %arg1  : i9
    %2 = llvm.icmp "ne" %1, %0 : i9
    llvm.return %2 : i1
  }
  llvm.func @test12(%arg0: i43) -> i43 {
    %0 = llvm.mlir.constant(0 : i43) : i43
    %1 = llvm.mlir.constant(42 : i43) : i43
    %2 = llvm.ashr %arg0, %1  : i43
    %3 = llvm.sub %0, %2  : i43
    llvm.return %3 : i43
  }
  llvm.func @test13(%arg0: i79) -> i79 {
    %0 = llvm.mlir.constant(0 : i79) : i79
    %1 = llvm.mlir.constant(78 : i79) : i79
    %2 = llvm.lshr %arg0, %1  : i79
    %3 = llvm.sub %0, %2  : i79
    llvm.return %3 : i79
  }
  llvm.func @test14(%arg0: i1024) -> i1024 {
    %0 = llvm.mlir.constant(0 : i1024) : i1024
    %1 = llvm.mlir.constant(1023 : i1024) : i1024
    %2 = llvm.lshr %arg0, %1  : i1024
    %3 = llvm.bitcast %2 : i1024 to i1024
    %4 = llvm.sub %0, %3  : i1024
    llvm.return %4 : i1024
  }
  llvm.func @test16(%arg0: i51) -> i51 {
    %0 = llvm.mlir.constant(0 : i51) : i51
    %1 = llvm.mlir.constant(1123 : i51) : i51
    %2 = llvm.sdiv %arg0, %1  : i51
    %3 = llvm.sub %0, %2  : i51
    llvm.return %3 : i51
  }
  llvm.func @test17(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(1234 : i25) : i25
    %1 = llvm.mlir.constant(0 : i25) : i25
    %2 = llvm.sub %1, %arg0  : i25
    %3 = llvm.sdiv %2, %0  : i25
    llvm.return %3 : i25
  }
  llvm.func @test18(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(2 : i128) : i128
    %1 = llvm.shl %arg0, %0  : i128
    %2 = llvm.shl %arg0, %0  : i128
    %3 = llvm.sub %1, %2  : i128
    llvm.return %3 : i128
  }
  llvm.func @test19(%arg0: i39, %arg1: i39) -> i39 {
    %0 = llvm.sub %arg0, %arg1  : i39
    %1 = llvm.add %0, %arg1  : i39
    llvm.return %1 : i39
  }
  llvm.func @test20(%arg0: i33, %arg1: i33) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i33
    %1 = llvm.icmp "ne" %0, %arg0 : i33
    llvm.return %1 : i1
  }
  llvm.func @test21(%arg0: i256, %arg1: i256) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i256
    %1 = llvm.icmp "ne" %0, %arg0 : i256
    llvm.return %1 : i1
  }
}
