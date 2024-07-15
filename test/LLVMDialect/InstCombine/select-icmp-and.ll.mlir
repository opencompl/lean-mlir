module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test5(%arg0: i41) -> i41 {
    %0 = llvm.mlir.constant(32 : i41) : i41
    %1 = llvm.mlir.constant(0 : i41) : i41
    %2 = llvm.and %arg0, %0  : i41
    %3 = llvm.icmp "ne" %2, %1 : i41
    %4 = llvm.select %3, %0, %1 : i1, i41
    llvm.return %4 : i41
  }
  llvm.func @test6(%arg0: i1023) -> i1023 {
    %0 = llvm.mlir.constant(64 : i1023) : i1023
    %1 = llvm.mlir.constant(0 : i1023) : i1023
    %2 = llvm.and %arg0, %0  : i1023
    %3 = llvm.icmp "ne" %2, %1 : i1023
    %4 = llvm.select %3, %0, %1 : i1, i1023
    llvm.return %4 : i1023
  }
  llvm.func @test35(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @test35vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<60> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<100> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.icmp "sge" %arg0, %1 : vector<2xi32>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test35_with_trunc(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @test36(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @test36vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<60> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<100> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test37(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @test37vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %1, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test65(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test65vec(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi64>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi64>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @test66(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test66vec(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4294967296> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi64>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi64>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @test66vec_scalar_and(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    %6 = llvm.select %5, %2, %3 : i1, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @test67(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i16
    %5 = llvm.icmp "ne" %4, %1 : i16
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test67vec(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi16>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi16>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @test71(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test71vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @test72(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(40 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test72vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi32>
    %7 = llvm.select %6, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @test73(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(40 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.icmp "sgt" %3, %0 : i8
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @test73vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %4 = llvm.icmp "sgt" %3, %0 : vector<2xi8>
    %5 = llvm.select %4, %1, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test74(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(40 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @test74vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test75(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @test15a(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.select %3, %1, %0 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @test15b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @test15c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @test15d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @test15e(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.select %4, %2, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @test15f(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @test15g(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(-9 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test15h(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-9 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test15i(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(577 : i32) : i32
    %3 = llvm.mlir.constant(1089 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test15j(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1089 : i32) : i32
    %3 = llvm.mlir.constant(577 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @use1(i1)
  llvm.func @clear_to_set(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.mlir.constant(-11 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.call @use1(%5) : (i1) -> ()
    llvm.return %6 : i32
  }
  llvm.func @clear_to_clear(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-11 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.call @use1(%5) : (i1) -> ()
    llvm.return %6 : i32
  }
  llvm.func @set_to_set(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.mlir.constant(-11 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.call @use1(%5) : (i1) -> ()
    llvm.return %6 : i32
  }
  llvm.func @set_to_clear(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-11 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.call @use1(%5) : (i1) -> ()
    llvm.return %6 : i32
  }
  llvm.func @clear_to_set_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @clear_to_clear_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-125 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @set_to_set_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @set_to_clear_decomposebittest(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-125 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @clear_to_set_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }
  llvm.func @clear_to_clear_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-125 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }
  llvm.func @set_to_set_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-125 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }
  llvm.func @set_to_clear_decomposebittest_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-125 : i8) : i8
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @use1(%3) : (i1) -> ()
    llvm.return %4 : i8
  }
}
