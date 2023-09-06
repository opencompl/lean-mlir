module  {
  llvm.func @test_shift_and_cmp_not_changed1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.shl %arg0, %2  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %0 : i8
    llvm.return %5 : i1
  }
  llvm.func @test_shift_and_cmp_not_changed2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.ashr %arg0, %2  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %0 : i8
    llvm.return %5 : i1
  }
  llvm.func @test_shift_and_cmp_changed1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.constant(8 : i8) : i8
    %3 = llvm.mlir.constant(6 : i8) : i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.or %5, %4  : i8
    %7 = llvm.shl %6, %1  : i8
    %8 = llvm.ashr %7, %1  : i8
    %9 = llvm.icmp "slt" %8, %0 : i8
    llvm.return %9 : i1
  }
  llvm.func @test_shift_and_cmp_changed1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<8> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.and %arg0, %3  : vector<2xi8>
    %5 = llvm.and %arg1, %2  : vector<2xi8>
    %6 = llvm.or %5, %4  : vector<2xi8>
    %7 = llvm.shl %6, %1  : vector<2xi8>
    %8 = llvm.ashr %7, %1  : vector<2xi8>
    %9 = llvm.icmp "slt" %8, %0 : vector<2xi8>
    llvm.return %9 : i1
  }
  llvm.func @test_shift_and_cmp_changed2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.shl %arg0, %2  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "ult" %4, %0 : i8
    llvm.return %5 : i1
  }
  llvm.func @test_shift_and_cmp_changed2_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-64> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %arg0, %2  : vector<2xi8>
    %4 = llvm.and %3, %1  : vector<2xi8>
    %5 = llvm.icmp "ult" %4, %0 : vector<2xi8>
    llvm.return %5 : i1
  }
  llvm.func @test_shift_and_cmp_changed3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.shl %arg0, %2  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %0 : i8
    llvm.return %5 : i1
  }
  llvm.func @test_shift_and_cmp_changed4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.lshr %arg0, %2  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %0 : i8
    llvm.return %5 : i1
  }
}
