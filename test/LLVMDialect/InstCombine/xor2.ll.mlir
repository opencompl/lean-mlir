module  {
  llvm.func @test0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @test0vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.xor %arg0, %1  : vector<2xi32>
    %3 = llvm.icmp "sgt" %2, %0 : vector<2xi32>
    llvm.return %3 : i1
  }
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(12345 : i32) : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(153 : i32) : i32
    %1 = llvm.mlir.constant(145 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(153 : i32) : i32
    %1 = llvm.mlir.constant(177 : i32) : i32
    %2 = llvm.mlir.constant(145 : i32) : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(1234 : i32) : i32
    %3 = llvm.xor %arg0, %2  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.add %5, %3  : i32
    llvm.return %6 : i32
  }
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(1234 : i32) : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @test7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test9b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test10b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test11b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @test11c(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test11d(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @test11e(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg2  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %1, %3  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test11f(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg2  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %1, %3  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test12commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.xor %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test13commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @xor_or_xor_common_op_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_or_xor_common_op_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg2, %arg0  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_or_xor_common_op_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_or_xor_common_op_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg2, %arg0  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_or_xor_common_op_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_or_xor_common_op_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg2, %arg0  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_or_xor_common_op_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_or_xor_common_op_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg2, %arg0  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_or_xor_common_op_extra_use1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr<i32>) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    llvm.store %0, %arg3 : !llvm.ptr<i32>
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_or_xor_common_op_extra_use2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr<i32>) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    llvm.store %1, %arg3 : !llvm.ptr<i32>
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_or_xor_common_op_extra_use3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>) -> i32 {
    %0 = llvm.xor %arg0, %arg2  : i32
    llvm.store %0, %arg3 : !llvm.ptr<i32>
    %1 = llvm.or %arg0, %arg1  : i32
    llvm.store %1, %arg4 : !llvm.ptr<i32>
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test15(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.and %1, %3  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @test16(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }
}
