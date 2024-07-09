module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @use16(i16)
  llvm.func @testi16i8(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @testi16i8_com(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %3, %5 : i8
    llvm.return %6 : i1
  }
  llvm.func @testi16i8_ne(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "ne" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @testi16i8_ne_com(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "ne" %3, %5 : i8
    llvm.return %6 : i1
  }
  llvm.func @testi64i32(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.trunc %arg0 : i64 to i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %3 : i32
    llvm.return %6 : i1
  }
  llvm.func @testi64i32_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.trunc %arg0 : i64 to i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.icmp "ne" %5, %3 : i32
    llvm.return %6 : i1
  }
  llvm.func @testi32i8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @wrongimm1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @wrongimm2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @slt(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.trunc %arg0 : i64 to i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.icmp "slt" %5, %3 : i32
    llvm.return %6 : i1
  }
  llvm.func @extrause_a(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.call @use(%5) : (i8) -> ()
    llvm.return %6 : i1
  }
  llvm.func @extrause_l(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.call @use(%3) : (i8) -> ()
    llvm.return %6 : i1
  }
  llvm.func @extrause_la(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.call @use(%5) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.return %6 : i1
  }
}
