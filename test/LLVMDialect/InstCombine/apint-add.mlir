module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.add %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @test2(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(-70368744177664 : i47) : i47
    %1 = llvm.xor %arg0, %0  : i47
    %2 = llvm.add %1, %0  : i47
    llvm.return %2 : i47
  }
  llvm.func @test3(%arg0: i15) -> i15 {
    %0 = llvm.mlir.constant(-16384 : i15) : i15
    %1 = llvm.xor %arg0, %0  : i15
    %2 = llvm.add %1, %0  : i15
    llvm.return %2 : i15
  }
  llvm.func @test3vec(%arg0: vector<2xi5>) -> vector<2xi5> {
    %0 = llvm.mlir.constant(-16 : i5) : i5
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.add %arg0, %1  : vector<2xi5>
    llvm.return %2 : vector<2xi5>
  }
  llvm.func @test4(%arg0: i49) -> i49 {
    %0 = llvm.mlir.constant(-2 : i49) : i49
    %1 = llvm.mlir.constant(1 : i49) : i49
    %2 = llvm.and %arg0, %0  : i49
    %3 = llvm.add %2, %1  : i49
    llvm.return %3 : i49
  }
  llvm.func @sext(%arg0: i4) -> i7 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i7) : i7
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.zext %2 : i4 to i7
    %4 = llvm.add %3, %1 overflow<nsw>  : i7
    llvm.return %4 : i7
  }
  llvm.func @sext_vec(%arg0: vector<2xi3>) -> vector<2xi10> {
    %0 = llvm.mlir.constant(-4 : i3) : i3
    %1 = llvm.mlir.constant(dense<-4> : vector<2xi3>) : vector<2xi3>
    %2 = llvm.mlir.constant(-4 : i10) : i10
    %3 = llvm.mlir.constant(dense<-4> : vector<2xi10>) : vector<2xi10>
    %4 = llvm.xor %arg0, %1  : vector<2xi3>
    %5 = llvm.zext %4 : vector<2xi3> to vector<2xi10>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi10>
    llvm.return %6 : vector<2xi10>
  }
  llvm.func @sext_multiuse(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i7) : i7
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.zext %2 : i4 to i7
    %4 = llvm.add %3, %1 overflow<nsw>  : i7
    %5 = llvm.sdiv %3, %4  : i7
    %6 = llvm.trunc %5 : i7 to i4
    %7 = llvm.sdiv %6, %2  : i4
    llvm.return %7 : i4
  }
  llvm.func @test5(%arg0: i111) -> i111 {
    %0 = llvm.mlir.constant(1 : i111) : i111
    %1 = llvm.mlir.constant(110 : i111) : i111
    %2 = llvm.shl %0, %1  : i111
    %3 = llvm.xor %arg0, %2  : i111
    %4 = llvm.add %3, %2  : i111
    llvm.return %4 : i111
  }
  llvm.func @test6(%arg0: i65) -> i65 {
    %0 = llvm.mlir.constant(1 : i65) : i65
    %1 = llvm.mlir.constant(64 : i65) : i65
    %2 = llvm.shl %0, %1  : i65
    %3 = llvm.xor %arg0, %2  : i65
    %4 = llvm.add %3, %2  : i65
    llvm.return %4 : i65
  }
  llvm.func @test7(%arg0: i1024) -> i1024 {
    %0 = llvm.mlir.constant(1 : i1024) : i1024
    %1 = llvm.mlir.constant(1023 : i1024) : i1024
    %2 = llvm.shl %0, %1  : i1024
    %3 = llvm.xor %arg0, %2  : i1024
    %4 = llvm.add %3, %2  : i1024
    llvm.return %4 : i1024
  }
  llvm.func @test8(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(1 : i128) : i128
    %1 = llvm.mlir.constant(127 : i128) : i128
    %2 = llvm.mlir.constant(120 : i128) : i128
    %3 = llvm.shl %0, %1  : i128
    %4 = llvm.ashr %3, %2  : i128
    %5 = llvm.xor %arg0, %4  : i128
    %6 = llvm.add %5, %3  : i128
    llvm.return %6 : i128
  }
  llvm.func @test9(%arg0: i77) -> i77 {
    %0 = llvm.mlir.constant(562949953421310 : i77) : i77
    %1 = llvm.mlir.constant(1 : i77) : i77
    %2 = llvm.and %arg0, %0  : i77
    %3 = llvm.add %2, %1  : i77
    llvm.return %3 : i77
  }
}
