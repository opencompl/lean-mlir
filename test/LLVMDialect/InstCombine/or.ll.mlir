module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @test12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test14_commuted(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.icmp "ult" %arg1, %arg0 : i32
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test14_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test15_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @test16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test18(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test18_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @test18vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<100> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<50> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test20(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test21(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.or %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @test22(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test23(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-32768 : i16) : i16
    %2 = llvm.mlir.constant(8193 : i16) : i16
    %3 = llvm.lshr %arg0, %0  : i16
    %4 = llvm.or %3, %1  : i16
    %5 = llvm.xor %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @test23vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<-32768> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<8193> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.lshr %arg0, %0  : vector<2xi16>
    %4 = llvm.or %3, %1  : vector<2xi16>
    %5 = llvm.xor %4, %2  : vector<2xi16>
    llvm.return %5 : vector<2xi16>
  }
  llvm.func @test25(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(57 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg1, %1 : i32
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.xor %5, %2  : i1
    llvm.return %6 : i1
  }
  llvm.func @test25_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(57 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg1, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    %6 = llvm.xor %5, %2  : i1
    llvm.return %6 : i1
  }
  llvm.func @and_icmp_eq_0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.icmp "eq" %arg1, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @and_icmp_eq_0_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %3 = llvm.icmp "eq" %arg1, %1 : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @and_icmp_eq_0_vector_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi32>
    %8 = llvm.icmp "eq" %arg1, %6 : vector<2xi32>
    %9 = llvm.and %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @and_icmp_eq_0_vector_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.undef : vector<2xi32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi32>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xi32>
    %12 = llvm.icmp "eq" %arg0, %6 : vector<2xi32>
    %13 = llvm.icmp "eq" %arg1, %11 : vector<2xi32>
    %14 = llvm.and %12, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }
  llvm.func @and_icmp_eq_0_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg1, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @test27(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test27vec(%arg0: !llvm.vec<2 x ptr>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ptrtoint %arg0 : !llvm.vec<2 x ptr> to vector<2xi32>
    %3 = llvm.ptrtoint %arg1 : !llvm.vec<2 x ptr> to vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %1 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @test28(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.icmp "ne" %arg1, %0 : i32
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @test28_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @test29(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @test29vec(%arg0: !llvm.vec<2 x ptr>, %arg1: !llvm.vec<2 x ptr>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ptrtoint %arg0 : !llvm.vec<2 x ptr> to vector<2xi32>
    %3 = llvm.ptrtoint %arg1 : !llvm.vec<2 x ptr> to vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %1 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @test30(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32962 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.mlir.constant(40186 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.and %3, %2  : i32
    %6 = llvm.or %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @test30vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32962> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-65536> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<40186> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.or %arg0, %0  : vector<2xi32>
    %4 = llvm.and %arg0, %1  : vector<2xi32>
    %5 = llvm.and %3, %2  : vector<2xi32>
    %6 = llvm.or %5, %4  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @test31(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(194 : i64) : i64
    %1 = llvm.mlir.constant(250 : i64) : i64
    %2 = llvm.mlir.constant(32768 : i64) : i64
    %3 = llvm.mlir.constant(4294941696 : i64) : i64
    %4 = llvm.or %arg0, %0  : i64
    %5 = llvm.and %4, %1  : i64
    %6 = llvm.or %arg0, %2  : i64
    %7 = llvm.and %6, %3  : i64
    %8 = llvm.or %5, %7  : i64
    llvm.return %8 : i64
  }
  llvm.func @test31vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<194> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<250> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<32768> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<4294941696> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.or %arg0, %0  : vector<2xi64>
    %5 = llvm.and %4, %1  : vector<2xi64>
    %6 = llvm.or %arg0, %2  : vector<2xi64>
    %7 = llvm.and %6, %3  : vector<2xi64>
    %8 = llvm.or %5, %7  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }
  llvm.func @test32(%arg0: vector<4xi1>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %2 = llvm.and %arg1, %1  : vector<4xi32>
    %3 = llvm.xor %1, %0  : vector<4xi32>
    %4 = llvm.and %arg2, %3  : vector<4xi32>
    %5 = llvm.or %4, %2  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @test33(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i1
    %1 = llvm.or %0, %arg0  : i1
    llvm.return %1 : i1
  }
  llvm.func @test33_logical(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @test34(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.or %arg1, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @test35(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1135 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test36(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.constant(25 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.icmp "eq" %arg0, %2 : i32
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @test36_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(25 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    %7 = llvm.icmp "eq" %arg0, %3 : i32
    %8 = llvm.select %6, %2, %7 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @test37(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.constant(23 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.icmp "eq" %arg0, %2 : i32
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @test37_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.constant(23 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.icmp "eq" %arg0, %2 : i32
    %7 = llvm.select %5, %3, %6 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @test37_uniform(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<23> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.add %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi32>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi32>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @test37_poison(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(30 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.mlir.constant(23 : i32) : i32
    %14 = llvm.mlir.undef : vector<2xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<2xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<2xi32>
    %19 = llvm.add %arg0, %6  : vector<2xi32>
    %20 = llvm.icmp "ult" %19, %12 : vector<2xi32>
    %21 = llvm.icmp "eq" %arg0, %18 : vector<2xi32>
    %22 = llvm.or %20, %21  : vector<2xi1>
    llvm.return %22 : vector<2xi1>
  }
  llvm.func @test38(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(23 : i32) : i32
    %2 = llvm.mlir.constant(30 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.icmp "ult" %3, %2 : i32
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @test38_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(23 : i32) : i32
    %2 = llvm.mlir.constant(30 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.icmp "ult" %4, %2 : i32
    %7 = llvm.select %5, %3, %6 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @test38_nonuniform(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[7, 24]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[23, 8]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[30, 32]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.add %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %5 = llvm.icmp "ult" %3, %2 : vector<2xi32>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @test39a(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.bitcast %arg1 : f32 to i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @test39b(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.bitcast %arg1 : f32 to i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @test39c(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.bitcast %arg1 : f32 to i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @test39d(%arg0: i32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.bitcast %arg1 : f32 to i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @test40(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test40b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test40c(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test40d(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test45(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test45_uses1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test45_uses2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test45_commuted1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.or %0, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.or %0, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test45_commuted2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.or %0, %arg2  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.or %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @test45_commuted3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.mul %arg2, %arg2  : i32
    %2 = llvm.or %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.or %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @test46(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-97 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.mlir.constant(-65 : i8) : i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    %5 = llvm.add %arg0, %2  : i8
    %6 = llvm.icmp "ult" %5, %1 : i8
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @test46_logical(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-97 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.mlir.constant(-65 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.add %arg0, %0  : i8
    %5 = llvm.icmp "ult" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.icmp "ult" %6, %1 : i8
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @test46_uniform(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-97> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<26> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-65> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi8>
    %5 = llvm.add %arg0, %2  : vector<2xi8>
    %6 = llvm.icmp "ult" %5, %1 : vector<2xi8>
    %7 = llvm.or %4, %6  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @test46_poison(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-97 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(26 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.mlir.constant(-65 : i8) : i8
    %14 = llvm.mlir.undef : vector<2xi8>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<2xi8>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<2xi8>
    %19 = llvm.add %arg0, %6  : vector<2xi8>
    %20 = llvm.icmp "ult" %19, %12 : vector<2xi8>
    %21 = llvm.add %arg0, %18  : vector<2xi8>
    %22 = llvm.icmp "ult" %21, %12 : vector<2xi8>
    %23 = llvm.or %20, %22  : vector<2xi1>
    llvm.return %23 : vector<2xi1>
  }
  llvm.func @two_ranges_to_mask_and_range_degenerate(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.mlir.constant(16 : i16) : i16
    %2 = llvm.mlir.constant(28 : i16) : i16
    %3 = llvm.icmp "ult" %arg0, %0 : i16
    %4 = llvm.icmp "uge" %arg0, %1 : i16
    %5 = llvm.icmp "ult" %arg0, %2 : i16
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.or %3, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @test47(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-65 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.mlir.constant(-97 : i8) : i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ule" %3, %1 : i8
    %5 = llvm.add %arg0, %2  : i8
    %6 = llvm.icmp "ule" %5, %1 : i8
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @test47_logical(%arg0: i8 {llvm.signext}) -> i1 {
    %0 = llvm.mlir.constant(-65 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.mlir.constant(-97 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.add %arg0, %0  : i8
    %5 = llvm.icmp "ule" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.icmp "ule" %6, %1 : i8
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @test47_nonuniform(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-65, -97]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<26> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[-97, -65]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ule" %3, %1 : vector<2xi8>
    %5 = llvm.add %arg0, %2  : vector<2xi8>
    %6 = llvm.icmp "ule" %5, %1 : vector<2xi8>
    %7 = llvm.or %4, %6  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @test49(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @test49vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.or %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test49vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.or %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test50(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @test50vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test50vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @or_andn_cmp_1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %2 = llvm.icmp "sle" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.and %3, %2  : i1
    %5 = llvm.or %1, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @or_andn_cmp_1_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.icmp "sle" %arg0, %arg1 : i32
    %5 = llvm.icmp "ugt" %arg2, %0 : i32
    %6 = llvm.select %5, %4, %1 : i1, i1
    %7 = llvm.select %3, %2, %6 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @or_andn_cmp_2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 47]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sge" %arg0, %arg1 : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<2xi32>
    %4 = llvm.and %3, %2  : vector<2xi1>
    %5 = llvm.or %4, %1  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @or_andn_cmp_3(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %2 = llvm.icmp "ule" %arg0, %arg1 : i72
    %3 = llvm.icmp "ugt" %arg2, %0 : i72
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.or %1, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @or_andn_cmp_3_logical(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %4 = llvm.icmp "ule" %arg0, %arg1 : i72
    %5 = llvm.icmp "ugt" %arg2, %0 : i72
    %6 = llvm.select %4, %5, %1 : i1, i1
    %7 = llvm.select %3, %2, %6 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @or_andn_cmp_4(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<[42, 43, -1]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.icmp "eq" %arg0, %arg1 : vector<3xi32>
    %2 = llvm.icmp "ne" %arg0, %arg1 : vector<3xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<3xi32>
    %4 = llvm.and %2, %3  : vector<3xi1>
    %5 = llvm.or %4, %1  : vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }
  llvm.func @orn_and_cmp_1(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i37
    %2 = llvm.icmp "sle" %arg0, %arg1 : i37
    %3 = llvm.icmp "ugt" %arg2, %0 : i37
    %4 = llvm.and %3, %1  : i1
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @orn_and_cmp_1_logical(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i37
    %4 = llvm.icmp "sle" %arg0, %arg1 : i37
    %5 = llvm.icmp "ugt" %arg2, %0 : i37
    %6 = llvm.select %5, %3, %1 : i1, i1
    %7 = llvm.select %4, %2, %6 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @orn_and_cmp_2(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.icmp "sge" %arg0, %arg1 : i16
    %2 = llvm.icmp "slt" %arg0, %arg1 : i16
    %3 = llvm.icmp "ugt" %arg2, %0 : i16
    %4 = llvm.and %3, %1  : i1
    %5 = llvm.or %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @orn_and_cmp_2_logical(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sge" %arg0, %arg1 : i16
    %4 = llvm.icmp "slt" %arg0, %arg1 : i16
    %5 = llvm.icmp "ugt" %arg2, %0 : i16
    %6 = llvm.select %5, %3, %1 : i1, i1
    %7 = llvm.select %6, %2, %4 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @orn_and_cmp_3(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[42, 0, 1, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<4xi32>
    %2 = llvm.icmp "ule" %arg0, %arg1 : vector<4xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<4xi32>
    %4 = llvm.and %1, %3  : vector<4xi1>
    %5 = llvm.or %2, %4  : vector<4xi1>
    llvm.return %5 : vector<4xi1>
  }
  llvm.func @orn_and_cmp_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.and %1, %3  : i1
    %5 = llvm.or %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @orn_and_cmp_4_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %arg1 : i32
    %4 = llvm.icmp "ne" %arg0, %arg1 : i32
    %5 = llvm.icmp "ugt" %arg2, %0 : i32
    %6 = llvm.select %3, %5, %1 : i1, i1
    %7 = llvm.select %6, %2, %4 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @test51(%arg0: vector<16xi1>, %arg1: vector<16xi1>) -> vector<16xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, true, true, true, false, true, true, false, false, true, true, false, false, false, false, false]> : vector<16xi1>) : vector<16xi1>
    %3 = llvm.mlir.constant(dense<[false, false, false, false, true, false, false, true, true, false, false, true, true, true, true, true]> : vector<16xi1>) : vector<16xi1>
    %4 = llvm.and %arg0, %2  : vector<16xi1>
    %5 = llvm.and %arg1, %3  : vector<16xi1>
    %6 = llvm.or %4, %5  : vector<16xi1>
    llvm.return %6 : vector<16xi1>
  }
  llvm.func @PR46712(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.or %arg0, %arg1  : i1
    %5 = llvm.sext %4 : i1 to i32
    %6 = llvm.icmp "sge" %5, %0 : i32
    %7 = llvm.zext %6 : i1 to i64
    llvm.cond_br %arg2, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %8 = llvm.icmp "eq" %7, %2 : i64
    %9 = llvm.icmp "ne" %arg3, %2 : i64
    %10 = llvm.and %8, %9  : i1
    %11 = llvm.select %10, %1, %3 : i1, i1
    llvm.br ^bb2(%11 : i1)
  ^bb2(%12: i1):  // 2 preds: ^bb0, ^bb1
    %13 = llvm.zext %12 : i1 to i32
    llvm.return %13 : i32
  }
  llvm.func @PR46712_logical(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.select %arg0, %0, %arg1 : i1, i1
    %5 = llvm.sext %4 : i1 to i32
    %6 = llvm.icmp "sge" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i64
    llvm.cond_br %arg2, ^bb1, ^bb2(%2 : i1)
  ^bb1:  // pred: ^bb0
    %8 = llvm.icmp "eq" %7, %3 : i64
    %9 = llvm.icmp "ne" %arg3, %3 : i64
    %10 = llvm.select %8, %9, %2 : i1, i1
    %11 = llvm.select %10, %2, %0 : i1, i1
    llvm.br ^bb2(%11 : i1)
  ^bb2(%12: i1):  // 2 preds: ^bb0, ^bb1
    %13 = llvm.zext %12 : i1 to i32
    llvm.return %13 : i32
  }
  llvm.func @PR38929(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.or %arg1, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg1, %arg0  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %arg1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @test4_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.or %arg1, %arg0  : vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    %3 = llvm.xor %arg1, %arg0  : vector<2xi32>
    %4 = llvm.or %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test5_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg1, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @test5_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg1, %arg0  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @test5_use3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.xor %arg1, %arg0  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.or %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @ashr_bitwidth_mask_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg1, %0  : vector<2xi8>
    %3 = llvm.ashr %arg0, %1  : vector<2xi8>
    %4 = llvm.or %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @ashr_bitwidth_mask_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @ashr_not_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.or %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @lshr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.or %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @cmp_overlap(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0  : i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @cmp_overlap_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mlir.constant(dense<0> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(-1 : i5) : i5
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.icmp "slt" %arg0, %1 : vector<2xi5>
    %5 = llvm.sub %1, %arg0  : vector<2xi5>
    %6 = llvm.icmp "sgt" %5, %3 : vector<2xi5>
    %7 = llvm.or %4, %6  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @mul_no_common_bits(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %arg1, %1  : i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @mul_no_common_bits_const_op(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @mul_no_common_bits_commute(%arg0: vector<2xi12>) -> vector<2xi12> {
    %0 = llvm.mlir.constant(1 : i12) : i12
    %1 = llvm.mlir.constant(dense<1> : vector<2xi12>) : vector<2xi12>
    %2 = llvm.mlir.constant(16 : i12) : i12
    %3 = llvm.mlir.constant(14 : i12) : i12
    %4 = llvm.mlir.constant(dense<[14, 16]> : vector<2xi12>) : vector<2xi12>
    %5 = llvm.and %arg0, %1  : vector<2xi12>
    %6 = llvm.mul %5, %4  : vector<2xi12>
    %7 = llvm.or %5, %6  : vector<2xi12>
    llvm.return %7 : vector<2xi12>
  }
  llvm.func @mul_no_common_bits_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %arg1, %1  : i32
    %4 = llvm.mul %3, %2  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @mul_no_common_bits_disjoint(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    %1 = llvm.or %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @mul_no_common_bits_const_op_disjoint(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @mul_no_common_bits_uses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %arg1, %1  : i32
    %4 = llvm.mul %2, %3  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @mul_no_common_bits_const_op_uses(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @mul_common_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_or_not_or_logical_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %6 = llvm.icmp "eq" %arg0, %1 : vector<4xi32>
    %7 = llvm.icmp "eq" %arg1, %1 : vector<4xi32>
    %8 = llvm.xor %6, %3  : vector<4xi1>
    %9 = llvm.select %7, %8, %5 : vector<4xi1>, vector<4xi1>
    %10 = llvm.or %7, %6  : vector<4xi1>
    %11 = llvm.xor %10, %3  : vector<4xi1>
    %12 = llvm.or %9, %11  : vector<4xi1>
    llvm.return %12 : vector<4xi1>
  }
  llvm.func @drop_disjoint(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @assoc_cast_assoc_disjoint(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @test_or_and_disjoint(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %3  : i32
    %7 = llvm.or %6, %1  : i32
    llvm.return %7 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }
  llvm.func @test_or_and_mixed(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(11 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %3  : i32
    %7 = llvm.or %6, %1  : i32
    llvm.return %7 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }
  llvm.func @test_or_and_disjoint_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %7 = llvm.and %arg0, %3  : i32
    %8 = llvm.or %7, %4  : i32
    llvm.return %8 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }
  llvm.func @test_or_and_disjoint_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.and %arg0, %3  : i32
    llvm.call @use(%6) : (i32) -> ()
    %7 = llvm.or %6, %1  : i32
    llvm.return %7 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }
  llvm.func @test_or_and_xor_constant(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @test_or_and_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_and_xor_commuted1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg1, %arg0  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_and_xor_commuted2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg2, %arg2  : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.and %0, %1  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test_or_and_xor_commuted3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg0  : i32
    %1 = llvm.xor %0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.or %0, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test_or_and_xor_multiuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_and_xor_mismatched_op(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.or %1, %arg3  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_and_xor_multiuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_add_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.add %0, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_and_and_multiuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    llvm.call @use(%0) : (i32) -> ()
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @or_xor_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg2  : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @or_xor_and_uses1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg2  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @or_xor_and_uses2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg2  : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @or_xor_and_commuted1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.or %0, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @or_xor_and_commuted2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.and %0, %arg2  : i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.or %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_xor_and_commuted3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.mul %arg2, %arg2  : i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.xor %2, %arg0  : i32
    %4 = llvm.or %3, %0  : i32
    llvm.return %4 : i32
  }
}
