module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test0(%arg0: i39) -> i39 {
    %0 = llvm.mlir.constant(0 : i39) : i39
    %1 = llvm.and %arg0, %0  : i39
    llvm.return %1 : i39
  }
  llvm.func @test2(%arg0: i15) -> i15 {
    %0 = llvm.mlir.constant(-1 : i15) : i15
    %1 = llvm.and %arg0, %0  : i15
    llvm.return %1 : i15
  }
  llvm.func @test3(%arg0: i23) -> i23 {
    %0 = llvm.mlir.constant(127 : i23) : i23
    %1 = llvm.mlir.constant(128 : i23) : i23
    %2 = llvm.and %arg0, %0  : i23
    %3 = llvm.and %2, %1  : i23
    llvm.return %3 : i23
  }
  llvm.func @test4(%arg0: i37) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i37) : i37
    %1 = llvm.mlir.constant(0 : i37) : i37
    %2 = llvm.and %arg0, %0  : i37
    %3 = llvm.icmp "ne" %2, %1 : i37
    llvm.return %3 : i1
  }
  llvm.func @test5(%arg0: i7, %arg1: !llvm.ptr) -> i7 {
    %0 = llvm.mlir.constant(3 : i7) : i7
    %1 = llvm.mlir.constant(12 : i7) : i7
    %2 = llvm.or %arg0, %0  : i7
    %3 = llvm.xor %2, %1  : i7
    llvm.store %3, %arg1 {alignment = 1 : i64} : i7, !llvm.ptr
    %4 = llvm.and %3, %0  : i7
    llvm.return %4 : i7
  }
  llvm.func @test7(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(39 : i47) : i47
    %1 = llvm.mlir.constant(255 : i47) : i47
    %2 = llvm.ashr %arg0, %0  : i47
    %3 = llvm.and %2, %1  : i47
    llvm.return %3 : i47
  }
  llvm.func @test8(%arg0: i999) -> i999 {
    %0 = llvm.mlir.constant(0 : i999) : i999
    %1 = llvm.and %arg0, %0  : i999
    llvm.return %1 : i999
  }
  llvm.func @test9(%arg0: i1005) -> i1005 {
    %0 = llvm.mlir.constant(-1 : i1005) : i1005
    %1 = llvm.and %arg0, %0  : i1005
    llvm.return %1 : i1005
  }
  llvm.func @test10(%arg0: i123) -> i123 {
    %0 = llvm.mlir.constant(127 : i123) : i123
    %1 = llvm.mlir.constant(128 : i123) : i123
    %2 = llvm.and %arg0, %0  : i123
    %3 = llvm.and %2, %1  : i123
    llvm.return %3 : i123
  }
  llvm.func @test11(%arg0: i737) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i737) : i737
    %1 = llvm.mlir.constant(0 : i737) : i737
    %2 = llvm.and %arg0, %0  : i737
    %3 = llvm.icmp "ne" %2, %1 : i737
    llvm.return %3 : i1
  }
  llvm.func @test12(%arg0: i117, %arg1: !llvm.ptr) -> i117 {
    %0 = llvm.mlir.constant(3 : i117) : i117
    %1 = llvm.mlir.constant(12 : i117) : i117
    %2 = llvm.or %arg0, %0  : i117
    %3 = llvm.xor %2, %1  : i117
    llvm.store %3, %arg1 {alignment = 4 : i64} : i117, !llvm.ptr
    %4 = llvm.and %3, %0  : i117
    llvm.return %4 : i117
  }
  llvm.func @test13(%arg0: i1024) -> i1024 {
    %0 = llvm.mlir.constant(1016 : i1024) : i1024
    %1 = llvm.mlir.constant(255 : i1024) : i1024
    %2 = llvm.ashr %arg0, %0  : i1024
    %3 = llvm.and %2, %1  : i1024
    llvm.return %3 : i1024
  }
}
