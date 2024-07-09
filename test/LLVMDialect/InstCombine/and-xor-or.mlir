module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g() {addr_space = 0 : i32} : i8
  llvm.func @use(i32)
  llvm.func @use_i8(i8)
  llvm.func @use_i1(i1)
  llvm.func @and_xor_common_op(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %1, %arg1  : i32
    %4 = llvm.xor %2, %3  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @and_xor_common_op_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %1, %arg1  : i32
    %4 = llvm.xor %3, %2  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @and_xor_common_op_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %1, %arg1  : i32
    %4 = llvm.xor %3, %2  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @and_xor_common_op_commute3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[43, 42]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %0, %arg0  : vector<2xi32>
    %3 = llvm.udiv %1, %arg1  : vector<2xi32>
    %4 = llvm.xor %2, %3  : vector<2xi32>
    %5 = llvm.and %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @and_xor_common_op_constant(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.xor %arg0, %0  : vector<4xi32>
    %2 = llvm.and %0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @and_xor_not_common_op(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_xor_not_common_op_extrause(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_not_xor_common_op(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @gen32() -> i32
  llvm.func @and_not_xor_common_op_commutative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @or(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0  : i64
    %1 = llvm.xor %arg1, %arg0  : i64
    %2 = llvm.add %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @or2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0  : i64
    %1 = llvm.xor %arg1, %arg0  : i64
    %2 = llvm.or %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @and_xor_or1(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %1, %2  : i64
    %5 = llvm.xor %4, %3  : i64
    %6 = llvm.or %5, %2  : i64
    llvm.return %6 : i64
  }
  llvm.func @and_xor_or2(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.xor %4, %3  : i64
    %6 = llvm.or %5, %2  : i64
    llvm.return %6 : i64
  }
  llvm.func @and_xor_or3(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %1, %2  : i64
    %5 = llvm.xor %3, %4  : i64
    %6 = llvm.or %5, %2  : i64
    llvm.return %6 : i64
  }
  llvm.func @and_xor_or4(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.xor %3, %4  : i64
    %6 = llvm.or %5, %2  : i64
    llvm.return %6 : i64
  }
  llvm.func @and_xor_or5(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %1, %2  : i64
    %5 = llvm.xor %4, %3  : i64
    %6 = llvm.or %2, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @and_xor_or6(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.xor %4, %3  : i64
    %6 = llvm.or %2, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @and_xor_or7(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %1, %2  : i64
    %5 = llvm.xor %3, %4  : i64
    %6 = llvm.or %2, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @and_xor_or8(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.udiv %0, %arg0  : i64
    %2 = llvm.udiv %0, %arg1  : i64
    %3 = llvm.udiv %0, %arg2  : i64
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.xor %3, %4  : i64
    %6 = llvm.or %2, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @and_xor_or_negative(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i64 {
    %0 = llvm.and %arg1, %arg0  : i64
    %1 = llvm.xor %arg2, %0  : i64
    %2 = llvm.or %arg3, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @and_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg3  : i8
    %1 = llvm.shl %arg1, %arg3  : i8
    %2 = llvm.and %0, %arg2  : i8
    %3 = llvm.and %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg3  : i8
    %1 = llvm.shl %arg1, %arg3  : i8
    %2 = llvm.or %0, %arg2  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @xor_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.shl %arg0, %arg3  : i8
    %3 = llvm.shl %arg1, %arg3  : i8
    %4 = llvm.xor %1, %2  : i8
    %5 = llvm.xor %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @and_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.lshr %arg0, %arg3  : i8
    %3 = llvm.lshr %arg1, %arg3  : i8
    %4 = llvm.and %1, %2  : i8
    %5 = llvm.and %3, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg3  : i8
    %1 = llvm.lshr %arg1, %arg3  : i8
    %2 = llvm.or %0, %arg2  : i8
    %3 = llvm.or %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @xor_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg3  : i8
    %1 = llvm.lshr %arg1, %arg3  : i8
    %2 = llvm.xor %0, %arg2  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @and_ashr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.ashr %arg0, %arg3  : i8
    %3 = llvm.ashr %arg1, %arg3  : i8
    %4 = llvm.and %1, %2  : i8
    %5 = llvm.and %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_ashr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg2  : i8
    %2 = llvm.ashr %arg0, %arg3  : i8
    %3 = llvm.ashr %arg1, %arg3  : i8
    %4 = llvm.or %1, %2  : i8
    %5 = llvm.or %3, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @xor_ashr(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.ashr %arg0, %arg3  : vector<2xi8>
    %1 = llvm.ashr %arg1, %arg3  : vector<2xi8>
    %2 = llvm.xor %0, %arg2  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @or_and_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg3  : i8
    %1 = llvm.shl %arg1, %arg3  : i8
    %2 = llvm.or %0, %arg2  : i8
    %3 = llvm.and %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_lshr_shl(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg3  : i8
    %1 = llvm.shl %arg1, %arg3  : i8
    %2 = llvm.or %0, %arg2  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_lshr_shamt2(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.lshr %arg1, %arg3  : i8
    %3 = llvm.or %1, %arg2  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @xor_lshr_multiuse(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg3  : i8
    %1 = llvm.lshr %arg1, %arg3  : i8
    %2 = llvm.xor %0, %arg2  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.sdiv %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @sext_or_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.or %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @zext_or_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.zext %arg1 : i16 to i64
    %1 = llvm.zext %arg2 : i16 to i64
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.or %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @sext_and_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @zext_and_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.zext %arg1 : i16 to i64
    %1 = llvm.zext %arg2 : i16 to i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @sext_xor_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.xor %arg0, %0  : i64
    %3 = llvm.xor %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @zext_xor_chain(%arg0: i64, %arg1: i16, %arg2: i16) -> i64 {
    %0 = llvm.zext %arg1 : i16 to i64
    %1 = llvm.zext %arg2 : i16 to i64
    %2 = llvm.xor %arg0, %0  : i64
    %3 = llvm.xor %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @sext_or_chain_two_uses1(%arg0: i64, %arg1: i16, %arg2: i16, %arg3: i64) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.or %2, %1  : i64
    %4 = llvm.udiv %2, %arg3  : i64
    %5 = llvm.udiv %3, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @sext_or_chain_two_uses2(%arg0: i64, %arg1: i16, %arg2: i16, %arg3: i64) -> i64 {
    %0 = llvm.sext %arg1 : i16 to i64
    %1 = llvm.sext %arg2 : i16 to i64
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.or %2, %1  : i64
    %4 = llvm.udiv %3, %arg3  : i64
    %5 = llvm.udiv %3, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @not_and_and_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.and %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_not_4i64(%arg0: vector<4xi64>, %arg1: vector<4xi64>, %arg2: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.sdiv %0, %arg0  : vector<4xi64>
    %3 = llvm.xor %arg1, %1  : vector<4xi64>
    %4 = llvm.xor %arg2, %1  : vector<4xi64>
    %5 = llvm.and %2, %3  : vector<4xi64>
    %6 = llvm.and %5, %4  : vector<4xi64>
    llvm.return %6 : vector<4xi64>
  }
  llvm.func @not_and_and_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %1, %arg0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @not_and_and_not_commute2_extra_not_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.and %4, %5  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_not_extra_and1_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.and %5, %4  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.or %2, %3  : i32
    %6 = llvm.or %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_not_2i6(%arg0: vector<2xi6>, %arg1: vector<2xi6>, %arg2: vector<2xi6>) -> vector<2xi6> {
    %0 = llvm.mlir.constant(3 : i6) : i6
    %1 = llvm.mlir.constant(dense<3> : vector<2xi6>) : vector<2xi6>
    %2 = llvm.mlir.constant(-1 : i6) : i6
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi6>) : vector<2xi6>
    %4 = llvm.mlir.poison : i6
    %5 = llvm.mlir.undef : vector<2xi6>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<2xi6>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %4, %7[%8 : i32] : vector<2xi6>
    %10 = llvm.sdiv %1, %arg0  : vector<2xi6>
    %11 = llvm.xor %arg1, %3  : vector<2xi6>
    %12 = llvm.xor %arg2, %9  : vector<2xi6>
    %13 = llvm.or %10, %11  : vector<2xi6>
    %14 = llvm.or %13, %12  : vector<2xi6>
    llvm.return %14 : vector<2xi6>
  }
  llvm.func @not_or_or_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.or %1, %arg0  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @not_or_or_not_commute2_extra_not_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.or %2, %3  : i32
    %6 = llvm.or %4, %5  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_not_extra_or1_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.xor %arg2, %1  : i32
    %5 = llvm.or %2, %3  : i32
    %6 = llvm.or %5, %4  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @or_not_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %arg0, %arg2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.and %2, %7  : i32
    %9 = llvm.or %5, %8  : i32
    llvm.return %9 : i32
  }
  llvm.func @or_not_and_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %arg0, %arg2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.and %2, %7  : i32
    %9 = llvm.or %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @or_not_and_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg2, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    %6 = llvm.or %arg0, %2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.and %7, %arg1  : i32
    %9 = llvm.or %5, %8  : i32
    llvm.return %9 : i32
  }
  llvm.func @or_not_and_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg2  : i32
    %4 = llvm.or %2, %arg1  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %3, %5  : i32
    %7 = llvm.or %2, %3  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.and %8, %arg1  : i32
    %10 = llvm.or %6, %9  : i32
    llvm.return %10 : i32
  }
  llvm.func @or_not_and_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg2, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %arg2, %2  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.and %3, %8  : i32
    %10 = llvm.or %6, %9  : i32
    llvm.return %10 : i32
  }
  llvm.func @or_not_and_commute9(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.sdiv %0, %arg2  : i32
    %5 = llvm.or %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.and %6, %4  : i32
    %8 = llvm.or %2, %4  : i32
    %9 = llvm.xor %8, %1  : i32
    %10 = llvm.and %3, %9  : i32
    %11 = llvm.or %7, %10  : i32
    llvm.return %11 : i32
  }
  llvm.func @or_not_and_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_extra_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_extra_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_wrong_c(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg3  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.or %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %arg3  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_not_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %arg0, %arg2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.or %2, %7  : i32
    %9 = llvm.and %5, %8  : i32
    llvm.return %9 : i32
  }
  llvm.func @and_not_or_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %arg0, %arg2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.or %2, %7  : i32
    %9 = llvm.and %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @and_not_or_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg2, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.or %7, %arg1  : i32
    %9 = llvm.and %5, %8  : i32
    llvm.return %9 : i32
  }
  llvm.func @and_not_or_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg2  : i32
    %4 = llvm.and %2, %arg1  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.or %3, %5  : i32
    %7 = llvm.and %2, %3  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.or %8, %arg1  : i32
    %10 = llvm.and %6, %9  : i32
    llvm.return %10 : i32
  }
  llvm.func @and_not_or_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg2, %arg0  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %arg2, %2  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.or %3, %8  : i32
    %10 = llvm.and %6, %9  : i32
    llvm.return %10 : i32
  }
  llvm.func @and_not_or_commute9(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.sdiv %0, %arg1  : i32
    %4 = llvm.sdiv %0, %arg2  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    %8 = llvm.and %2, %4  : i32
    %9 = llvm.xor %8, %1  : i32
    %10 = llvm.or %3, %9  : i32
    %11 = llvm.and %7, %10  : i32
    llvm.return %11 : i32
  }
  llvm.func @and_not_or_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_extra_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_extra_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_wrong_c(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg3  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg2  : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.or %5, %arg3  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_and_not_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %arg0, %arg2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.and %2, %6  : i32
    %8 = llvm.or %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @or_and_not_not_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %arg2, %arg0  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.and %2, %6  : i32
    %8 = llvm.or %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @or_and_not_not_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_extra_and_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_2_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_wrong_a(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg3  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @or_and_not_not_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg3, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %2, %6  : i32
    %8 = llvm.and %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @and_or_not_not_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %2, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %arg2, %arg0  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %2, %6  : i32
    %8 = llvm.and %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @and_or_not_not_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg2, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_extra_not_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_extra_not_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_extra_and_use(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_extra_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_extra_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_2_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.and %2, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_wrong_a(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg3  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_or_not_not_wrong_b(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg3, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_not_or_or_not_or_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_or_not_or_xor_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg2, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_or_not_or_xor_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    %6 = llvm.xor %arg1, %arg2  : i32
    %7 = llvm.or %6, %2  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.or %5, %8  : i32
    llvm.return %9 : i32
  }
  llvm.func @and_not_or_or_not_or_xor_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg2, %arg1  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_or_not_or_xor_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    %6 = llvm.xor %arg1, %arg2  : i32
    %7 = llvm.or %2, %6  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.or %5, %8  : i32
    llvm.return %9 : i32
  }
  llvm.func @and_not_or_or_not_or_xor_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_or_not_or_xor_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_or_not_or_xor_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_or_not_or_xor_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_or_not_or_xor_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_or_not_or_xor_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @and_not_or_or_not_or_xor_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.or %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.or %3, %6  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_and_not_and_xor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_and_not_and_xor_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_and_not_and_xor_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.and %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.xor %arg1, %arg2  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.and %5, %8  : i32
    llvm.return %9 : i32
  }
  llvm.func @or_not_and_and_not_and_xor_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg2, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_and_not_and_xor_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.and %arg1, %arg2  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.xor %arg1, %arg2  : i32
    %7 = llvm.and %2, %6  : i32
    %8 = llvm.xor %7, %1  : i32
    %9 = llvm.and %5, %8  : i32
    llvm.return %9 : i32
  }
  llvm.func @or_not_and_and_not_and_xor_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_and_not_and_xor_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_and_not_and_xor_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_and_not_and_xor_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_and_not_and_xor_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_and_not_and_xor_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @or_not_and_and_not_and_xor_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %arg1, %arg2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.xor %5, %0  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or_commute1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg2, %arg0  : i32
    %2 = llvm.or %1, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or_commute2_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or_commute1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or_commute2_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %arg1, %arg2  : i32
    %6 = llvm.and %5, %4  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.or %arg1, %arg0  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.and %6, %arg1  : i32
    %8 = llvm.and %7, %2  : i32
    %9 = llvm.or %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @not_and_and_or_not_or_or_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.or %3, %arg2  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.and %2, %6  : i32
    %8 = llvm.and %7, %arg2  : i32
    %9 = llvm.or %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @not_and_and_or_not_or_or_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.or %arg1, %arg0  : i32
    %4 = llvm.or %3, %2  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.and %6, %arg1  : i32
    %8 = llvm.and %2, %7  : i32
    %9 = llvm.or %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @not_and_and_or_not_or_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_not_or_or_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.or %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.and %5, %arg2  : i32
    %7 = llvm.or %6, %3  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and_commute1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and_commute2_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and_commute1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and_commute2_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %arg1, %arg2  : i32
    %6 = llvm.or %5, %4  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.or %6, %arg1  : i32
    %8 = llvm.or %7, %2  : i32
    %9 = llvm.and %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @not_or_or_and_not_and_and_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.or %2, %6  : i32
    %8 = llvm.or %7, %arg2  : i32
    %9 = llvm.and %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @not_or_or_and_not_and_and_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.xor %arg0, %1  : i32
    %7 = llvm.or %6, %arg1  : i32
    %8 = llvm.or %2, %7  : i32
    %9 = llvm.and %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @not_or_or_and_not_and_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_or_or_and_not_and_and_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.or %5, %arg2  : i32
    %7 = llvm.and %6, %3  : i32
    llvm.call @use(%6) : (i32) -> ()
    llvm.return %7 : i32
  }
  llvm.func @not_and_and_or_no_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_or_no_or_commute1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %arg2, %arg1  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_or_no_or_commute2_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_or_no_or_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_or_no_or_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.xor %arg0, %1  : i32
    %6 = llvm.and %2, %5  : i32
    %7 = llvm.and %6, %arg2  : i32
    %8 = llvm.or %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @not_and_and_or_no_or_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.or %arg1, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.xor %arg0, %1  : i32
    %6 = llvm.and %5, %arg1  : i32
    %7 = llvm.and %2, %6  : i32
    %8 = llvm.or %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @not_and_and_or_no_or_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_or_no_or_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %arg1, %arg2  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_or_no_or_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_or_no_or_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg2  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_or_no_or_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_or_no_or_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_or_no_or_use7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_and_and_or_no_or_use8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.and %4, %arg2  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and_commute1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %arg2, %arg1  : i32
    %5 = llvm.or %4, %3  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and_commute2_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg2  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and_commute2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.xor %arg0, %1  : i32
    %6 = llvm.or %2, %5  : i32
    %7 = llvm.or %6, %arg2  : i32
    %8 = llvm.and %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @not_or_or_and_no_and_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg2  : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.xor %arg0, %1  : i32
    %6 = llvm.or %5, %arg1  : i32
    %7 = llvm.or %2, %6  : i32
    %8 = llvm.and %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @not_or_or_and_no_and_use1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and_use2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %arg1, %arg2  : i32
    %5 = llvm.or %4, %3  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and_use3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg2  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and_use4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg2  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and_use5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and_use6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and_use7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @not_or_or_and_no_and_use8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.or %4, %arg2  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.call @use(%5) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @and_orn_xor(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.or %2, %arg1  : i4
    %4 = llvm.and %3, %1  : i4
    llvm.return %4 : i4
  }
  llvm.func @and_orn_xor_commute1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.poison : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %8 = llvm.xor %arg0, %6  : vector<2xi4>
    %9 = llvm.or %8, %arg1  : vector<2xi4>
    %10 = llvm.and %7, %9  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }
  llvm.func @and_orn_xor_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_orn_xor_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_orn_xor_commute5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.xor %1, %0  : i32
    %5 = llvm.or %2, %4  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.and %5, %3  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_orn_xor_commute6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %1, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.xor %1, %0  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %3, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_orn_xor_commute7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.xor %1, %0  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.or %2, %4  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.and %5, %3  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_orn_xor_commute8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.xor %1, %0  : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %3, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @zext_zext_and_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.zext %arg1 : i8 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @sext_sext_or_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.sext %arg1 : i8 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @trunc_trunc_xor_uses(%arg0: i65, %arg1: i65) -> i32 {
    %0 = llvm.trunc %arg0 : i65 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.trunc %arg1 : i65 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @and_zext_zext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.zext %arg0 : i8 to i16
    %1 = llvm.zext %arg1 : i4 to i16
    %2 = llvm.and %0, %1  : i16
    llvm.return %2 : i16
  }
  llvm.func @or_zext_zext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.zext %arg0 : i8 to i16
    %1 = llvm.zext %arg1 : i4 to i16
    %2 = llvm.or %1, %0  : i16
    llvm.return %2 : i16
  }
  llvm.func @xor_zext_zext(%arg0: vector<2xi8>, %arg1: vector<2xi4>) -> vector<2xi16> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %1 = llvm.zext %arg1 : vector<2xi4> to vector<2xi16>
    %2 = llvm.xor %0, %1  : vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }
  llvm.func @and_sext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.sext %arg0 : i8 to i16
    %1 = llvm.sext %arg1 : i4 to i16
    %2 = llvm.and %1, %0  : i16
    llvm.return %2 : i16
  }
  llvm.func @or_sext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.sext %arg0 : i8 to i16
    %1 = llvm.sext %arg1 : i4 to i16
    %2 = llvm.or %0, %1  : i16
    llvm.return %2 : i16
  }
  llvm.func @xor_sext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.sext %arg0 : i8 to i16
    %1 = llvm.sext %arg1 : i4 to i16
    %2 = llvm.xor %0, %1  : i16
    llvm.return %2 : i16
  }
  llvm.func @and_zext_sext(%arg0: i8, %arg1: i4) -> i16 {
    %0 = llvm.zext %arg0 : i8 to i16
    %1 = llvm.sext %arg1 : i4 to i16
    %2 = llvm.and %0, %1  : i16
    llvm.return %2 : i16
  }
  llvm.func @and_zext_zext_use1(%arg0: i8, %arg1: i4) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.zext %arg1 : i4 to i32
    %2 = llvm.and %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @or_sext_sext_use1(%arg0: i8, %arg1: i4) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i4 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @PR56294(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.zext %3 : i1 to i32
    %6 = llvm.zext %4 : i8 to i32
    %7 = llvm.and %5, %6  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.return %8 : i1
  }
  llvm.func @canonicalize_logic_first_or0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @canonicalize_logic_first_or0_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @canonicalize_logic_first_or0_nswnuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @canonicalize_logic_first_or_vector0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<112> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_or_vector0_nsw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<112> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_or_vector0_nswnuw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<112> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw, nuw>  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_or_vector1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_or_vector1_nsw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_or_vector1_nswnuw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw, nuw>  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_or_vector2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2147483632, 2147483640]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_or_mult_use1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @canonicalize_logic_first_or_bad_constraints2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(112 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @canonicalize_logic_first_and0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @canonicalize_logic_first_and0_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @canonicalize_logic_first_and0_nswnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @canonicalize_logic_first_and_vector0(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %0, %arg0  : vector<2xi8>
    %3 = llvm.and %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @canonicalize_logic_first_and_vector0_nsw(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %0, %arg0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.and %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @canonicalize_logic_first_and_vector0_nswnuw(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %0, %arg0 overflow<nsw, nuw>  : vector<2xi8>
    %3 = llvm.and %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @canonicalize_logic_first_and_vector1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[48, 32]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-10, -4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %0, %arg0  : vector<2xi8>
    %3 = llvm.and %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @canonicalize_logic_first_and_vector2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<612368384> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65536, -32768]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.and %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_and_vector3(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[32768, 16384]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65536, -32768]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.and %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_and_mult_use1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-10 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use_i8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @canonicalize_logic_first_and_bad_constraints2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(-26 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @canonicalize_logic_first_xor_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @canonicalize_logic_first_xor_0_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @canonicalize_logic_first_xor_0_nswnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @canonicalize_logic_first_xor_vector0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-8388608> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32783> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_xor_vector0_nsw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-8388608> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32783> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_xor_vector0_nswnuw(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-8388608> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32783> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0 overflow<nsw, nuw>  : vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_xor_vector1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8388608, 2071986176]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_xor_vector2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2147483632, 2147483640]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[32783, 2063]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @canonicalize_logic_first_xor_mult_use1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use_i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @canonicalize_logic_first_xor_bad_constants2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @canonicalize_logic_first_constexpr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(-10 : i32) : i32
    %4 = llvm.add %1, %2  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @canonicalize_logic_first_constexpr_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(-10 : i32) : i32
    %4 = llvm.add %1, %2 overflow<nuw>  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @test_and_xor_freely_invertable(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.xor %0, %arg2  : i1
    %2 = llvm.and %1, %arg2  : i1
    llvm.return %2 : i1
  }
  llvm.func @test_and_xor_freely_invertable_multiuse(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.call @use_i1(%0) : (i1) -> ()
    %1 = llvm.xor %0, %arg2  : i1
    %2 = llvm.and %1, %arg2  : i1
    llvm.return %2 : i1
  }
}
