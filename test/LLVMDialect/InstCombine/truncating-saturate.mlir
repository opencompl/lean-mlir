module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @use16(i16)
  llvm.func @use1(i1)
  llvm.func @testi16i8(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }
  llvm.func @testi64i32(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.return %12 : i32
  }
  llvm.func @testi32i16i8(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(127 : i16) : i16
    %4 = llvm.mlir.constant(-128 : i16) : i16
    %5 = llvm.add %arg0, %0  : i32
    %6 = llvm.icmp "ult" %5, %1 : i32
    %7 = llvm.trunc %arg0 : i32 to i16
    %8 = llvm.icmp "sgt" %arg0, %2 : i32
    %9 = llvm.select %8, %3, %4 : i1, i16
    %10 = llvm.select %6, %7, %9 : i1, i16
    llvm.return %10 : i16
  }
  llvm.func @testv4i32i16i8(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<128> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<256> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<127> : vector<4xi16>) : vector<4xi16>
    %4 = llvm.mlir.constant(dense<-128> : vector<4xi16>) : vector<4xi16>
    %5 = llvm.add %arg0, %0  : vector<4xi32>
    %6 = llvm.icmp "ult" %5, %1 : vector<4xi32>
    %7 = llvm.trunc %arg0 : vector<4xi32> to vector<4xi16>
    %8 = llvm.icmp "sgt" %arg0, %2 : vector<4xi32>
    %9 = llvm.select %8, %3, %4 : vector<4xi1>, vector<4xi16>
    %10 = llvm.select %6, %7, %9 : vector<4xi1>, vector<4xi16>
    llvm.return %10 : vector<4xi16>
  }
  llvm.func @testi32i32i8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(127 : i32) : i32
    %4 = llvm.mlir.constant(-128 : i32) : i32
    %5 = llvm.add %arg0, %0  : i32
    %6 = llvm.icmp "ult" %5, %1 : i32
    %7 = llvm.icmp "sgt" %arg0, %2 : i32
    %8 = llvm.select %7, %3, %4 : i1, i32
    %9 = llvm.select %6, %arg0, %8 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @test_truncfirst(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(128 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(127 : i16) : i16
    %4 = llvm.mlir.constant(-128 : i16) : i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.add %5, %0  : i16
    %7 = llvm.icmp "ult" %6, %1 : i16
    %8 = llvm.icmp "sgt" %5, %2 : i16
    %9 = llvm.select %8, %3, %4 : i1, i16
    %10 = llvm.select %7, %5, %9 : i1, i16
    llvm.return %10 : i16
  }
  llvm.func @testtrunclowhigh(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.icmp "sgt" %arg0, %2 : i32
    %7 = llvm.select %6, %arg2, %arg1 : i1, i16
    %8 = llvm.select %4, %5, %7 : i1, i16
    llvm.return %8 : i16
  }
  llvm.func @testi64i32addsat(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.sext %arg0 : i32 to i64
    %5 = llvm.sext %arg1 : i32 to i64
    %6 = llvm.add %4, %5  : i64
    %7 = llvm.lshr %6, %0  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.trunc %6 : i64 to i32
    %10 = llvm.ashr %9, %1  : i32
    %11 = llvm.icmp "eq" %10, %8 : i32
    %12 = llvm.ashr %6, %2  : i64
    %13 = llvm.trunc %12 : i64 to i32
    %14 = llvm.xor %13, %3  : i32
    %15 = llvm.select %11, %9, %14 : i1, i32
    llvm.return %15 : i32
  }
  llvm.func @testv4i16i8(%arg0: vector<4xi16>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.constant(dense<7> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<15> : vector<4xi16>) : vector<4xi16>
    %3 = llvm.mlir.constant(dense<127> : vector<4xi8>) : vector<4xi8>
    %4 = llvm.lshr %arg0, %0  : vector<4xi16>
    %5 = llvm.trunc %4 : vector<4xi16> to vector<4xi8>
    %6 = llvm.trunc %arg0 : vector<4xi16> to vector<4xi8>
    %7 = llvm.ashr %6, %1  : vector<4xi8>
    %8 = llvm.icmp "eq" %7, %5 : vector<4xi8>
    %9 = llvm.ashr %arg0, %2  : vector<4xi16>
    %10 = llvm.trunc %9 : vector<4xi16> to vector<4xi8>
    %11 = llvm.xor %10, %3  : vector<4xi8>
    %12 = llvm.select %8, %6, %11 : vector<4xi1>, vector<4xi8>
    llvm.return %12 : vector<4xi8>
  }
  llvm.func @testv4i16i8add(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.constant(dense<7> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<15> : vector<4xi16>) : vector<4xi16>
    %3 = llvm.mlir.constant(dense<127> : vector<4xi8>) : vector<4xi8>
    %4 = llvm.sext %arg0 : vector<4xi8> to vector<4xi16>
    %5 = llvm.sext %arg1 : vector<4xi8> to vector<4xi16>
    %6 = llvm.add %4, %5  : vector<4xi16>
    %7 = llvm.lshr %6, %0  : vector<4xi16>
    %8 = llvm.trunc %7 : vector<4xi16> to vector<4xi8>
    %9 = llvm.trunc %6 : vector<4xi16> to vector<4xi8>
    %10 = llvm.ashr %9, %1  : vector<4xi8>
    %11 = llvm.icmp "eq" %10, %8 : vector<4xi8>
    %12 = llvm.ashr %6, %2  : vector<4xi16>
    %13 = llvm.trunc %12 : vector<4xi16> to vector<4xi8>
    %14 = llvm.xor %13, %3  : vector<4xi8>
    %15 = llvm.select %11, %9, %14 : vector<4xi1>, vector<4xi8>
    llvm.return %15 : vector<4xi8>
  }
  llvm.func @testi16i8_revcmp(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %5, %7 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }
  llvm.func @testi16i8_revselect(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "ne" %5, %7 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %11, %6 : i1, i8
    llvm.return %12 : i8
  }
  llvm.func @testi32i8(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i32
    %10 = llvm.trunc %9 : i32 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }
  llvm.func @differentconsts(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(144 : i32) : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i16
    %7 = llvm.add %arg0, %3  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    %9 = llvm.trunc %arg0 : i32 to i16
    %10 = llvm.select %8, %9, %6 : i1, i16
    llvm.return %10 : i16
  }
  llvm.func @badimm1(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }
  llvm.func @badimm2(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }
  llvm.func @badimm3(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(14 : i16) : i16
    %3 = llvm.mlir.constant(127 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }
  llvm.func @badimm4(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.constant(126 : i8) : i8
    %4 = llvm.lshr %arg0, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.trunc %arg0 : i16 to i8
    %7 = llvm.ashr %6, %1  : i8
    %8 = llvm.icmp "eq" %7, %5 : i8
    %9 = llvm.ashr %arg0, %2  : i16
    %10 = llvm.trunc %9 : i16 to i8
    %11 = llvm.xor %10, %3  : i8
    %12 = llvm.select %8, %6, %11 : i1, i8
    llvm.return %12 : i8
  }
  llvm.func @oneusexor(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.call @use(%11) : (i32) -> ()
    llvm.return %12 : i32
  }
  llvm.func @oneuseconv(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %12 : i32
  }
  llvm.func @oneusecmp(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.call @use1(%8) : (i1) -> ()
    llvm.return %12 : i32
  }
  llvm.func @oneuseboth(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.call @use(%11) : (i32) -> ()
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %12 : i32
  }
  llvm.func @oneusethree(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.ashr %6, %1  : i32
    %8 = llvm.icmp "eq" %7, %5 : i32
    %9 = llvm.ashr %arg0, %2  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.xor %10, %3  : i32
    %12 = llvm.select %8, %6, %11 : i1, i32
    llvm.call @use(%11) : (i32) -> ()
    llvm.call @use(%6) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.return %12 : i32
  }
  llvm.func @differentconsts_usetrunc(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(144 : i32) : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i16
    %7 = llvm.add %arg0, %3  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    %9 = llvm.trunc %arg0 : i32 to i16
    %10 = llvm.select %8, %9, %6 : i1, i16
    llvm.call @use16(%9) : (i16) -> ()
    llvm.return %10 : i16
  }
  llvm.func @differentconsts_useadd(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(144 : i32) : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i16
    %7 = llvm.add %arg0, %3  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    %9 = llvm.trunc %arg0 : i32 to i16
    %10 = llvm.select %8, %9, %6 : i1, i16
    llvm.call @use(%7) : (i32) -> ()
    llvm.return %10 : i16
  }
  llvm.func @differentconsts_useaddtrunc(%arg0: i32, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(144 : i32) : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i16
    %7 = llvm.add %arg0, %3  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    %9 = llvm.trunc %arg0 : i32 to i16
    %10 = llvm.select %8, %9, %6 : i1, i16
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use(%7) : (i32) -> ()
    llvm.return %10 : i16
  }
  llvm.func @C0zero(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-10 : i8) : i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    %5 = llvm.icmp "slt" %arg0, %2 : i8
    %6 = llvm.select %5, %arg1, %arg2 : i1, i8
    %7 = llvm.select %4, %arg0, %6 : i1, i8
    llvm.return %7 : i8
  }
  llvm.func @C0zeroV(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.add %arg0, %0  : vector<2xi8>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi8>
    %6 = llvm.icmp "slt" %arg0, %3 : vector<2xi8>
    %7 = llvm.select %6, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    %8 = llvm.select %5, %arg0, %7 : vector<2xi1>, vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
  llvm.func @C0zeroVu(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[0, 10]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi8>
    %5 = llvm.icmp "slt" %arg0, %2 : vector<2xi8>
    %6 = llvm.select %5, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    %7 = llvm.select %4, %arg0, %6 : vector<2xi1>, vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }
  llvm.func @f(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %1 : i1, i8
    %5 = llvm.icmp "ult" %arg0, %2 : i32
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.select %5, %6, %4 : i1, i8
    llvm.return %7 : i8
  }
}
