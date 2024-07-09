module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g() {addr_space = 0 : i32} : i32
  llvm.func @use(i64)
  llvm.func @shl_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_and_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.and %2, %arg1  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @shl_or(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.mlir.constant(7 : i16) : i16
    %3 = llvm.srem %arg1, %0  : i16
    %4 = llvm.shl %arg0, %1  : i16
    %5 = llvm.or %3, %4  : i16
    %6 = llvm.shl %5, %2  : i16
    llvm.return %6 : i16
  }
  llvm.func @shl_or_poison(%arg0: vector<2xi16>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.constant(5 : i16) : i16
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi16>
    %8 = llvm.mlir.constant(7 : i16) : i16
    %9 = llvm.mlir.undef : vector<2xi16>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi16>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi16>
    %14 = llvm.srem %arg1, %0  : vector<2xi16>
    %15 = llvm.shl %arg0, %7  : vector<2xi16>
    %16 = llvm.or %14, %15  : vector<2xi16>
    %17 = llvm.shl %16, %13  : vector<2xi16>
    llvm.return %17 : vector<2xi16>
  }
  llvm.func @shl_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @shl_xor_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[7, 8]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %arg1  : vector<2xi32>
    %4 = llvm.shl %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @lshr_and(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.srem %arg1, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %3, %4  : i64
    %6 = llvm.lshr %5, %2  : i64
    llvm.return %6 : i64
  }
  llvm.func @lshr_and_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.lshr %arg0, %7  : vector<2xi64>
    %16 = llvm.and %14, %15  : vector<2xi64>
    %17 = llvm.lshr %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }
  llvm.func @lshr_or(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<7> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %arg0, %0  : vector<4xi32>
    %3 = llvm.or %2, %arg1  : vector<4xi32>
    %4 = llvm.lshr %3, %1  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @lshr_xor(%arg0: vector<8xi16>, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<[42, 42, 42, 42, 42, 42, 42, -42]> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.mlir.constant(dense<5> : vector<8xi16>) : vector<8xi16>
    %2 = llvm.mlir.constant(dense<7> : vector<8xi16>) : vector<8xi16>
    %3 = llvm.srem %arg1, %0  : vector<8xi16>
    %4 = llvm.lshr %arg0, %1  : vector<8xi16>
    %5 = llvm.xor %3, %4  : vector<8xi16>
    %6 = llvm.lshr %5, %2  : vector<8xi16>
    llvm.return %6 : vector<8xi16>
  }
  llvm.func @ashr_and(%arg0: vector<16xi8>, %arg1: vector<16xi8>, %arg2: vector<16xi8>) -> vector<16xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<16xi8>) : vector<16xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<16xi8>) : vector<16xi8>
    %2 = llvm.srem %arg1, %arg2  : vector<16xi8>
    %3 = llvm.ashr %arg0, %0  : vector<16xi8>
    %4 = llvm.and %2, %3  : vector<16xi8>
    %5 = llvm.ashr %4, %1  : vector<16xi8>
    llvm.return %5 : vector<16xi8>
  }
  llvm.func @ashr_or(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi64>
    %3 = llvm.or %2, %arg1  : vector<2xi64>
    %4 = llvm.ashr %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @ashr_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.srem %arg1, %0  : i32
    %4 = llvm.ashr %arg0, %1  : i32
    %5 = llvm.xor %3, %4  : i32
    %6 = llvm.ashr %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @shr_mismatch_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.xor %arg1, %2  : i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_overshift_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.xor %arg1, %2  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_poison_poison_xor(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(17 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.ashr %arg0, %6  : vector<2xi32>
    %14 = llvm.xor %arg1, %13  : vector<2xi32>
    %15 = llvm.ashr %14, %12  : vector<2xi32>
    llvm.return %15 : vector<2xi32>
  }
  llvm.func @lshr_or_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.or %2, %arg1  : i32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @PR44028(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.shl %2, %0  : i32
    %5 = llvm.xor %3, %4  : i32
    %6 = llvm.ashr %5, %0  : i32
    llvm.return %6 : i32
  }
  llvm.func @lshr_mul(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @lshr_mul_nuw_nsw(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @lshr_mul_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<52> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.lshr %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @lshr_mul_negative_noexact(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(53 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @lshr_mul_negative_oneuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i64
    llvm.call @use(%2) : (i64) -> ()
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @lshr_mul_negative_nonuw(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @lshr_mul_negative_nsw(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(52 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i64
    %3 = llvm.lshr %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @shl_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.add %2, %arg1  : i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_add_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-42 : i8) : i8
    %2 = llvm.mlir.addressof @use : !llvm.ptr
    %3 = llvm.mlir.constant(2 : i8) : i8
    %4 = llvm.shl %arg0, %0  : i8
    %5 = llvm.add %4, %1  : i8
    llvm.call %2(%4) : !llvm.ptr, (i8) -> ()
    %6 = llvm.shl %5, %3  : i8
    llvm.return %6 : i8
  }
  llvm.func @shl_add_multiuse_nonconstant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.add %3, %arg1  : i8
    llvm.call %1(%3) : !llvm.ptr, (i8) -> ()
    %5 = llvm.shl %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_add_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %arg1  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @shl_add_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.shl %arg0, %7  : vector<2xi64>
    %16 = llvm.add %14, %15  : vector<2xi64>
    %17 = llvm.shl %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }
  llvm.func @lshr_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.add %2, %arg1  : i8
    %4 = llvm.lshr %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @lshr_add_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %arg1  : vector<2xi8>
    %4 = llvm.lshr %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @lshr_add_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.lshr %arg0, %7  : vector<2xi64>
    %16 = llvm.add %14, %15  : vector<2xi64>
    %17 = llvm.lshr %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }
  llvm.func @shl_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.sub %2, %arg1  : i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_sub_no_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg1, %0  : i8
    %3 = llvm.sub %arg0, %2  : i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_sub_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.sub %2, %arg1  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @shl_sub_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.shl %arg0, %7  : vector<2xi64>
    %16 = llvm.sub %14, %15  : vector<2xi64>
    %17 = llvm.shl %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }
  llvm.func @lshr_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.sub %2, %arg1  : i8
    %4 = llvm.lshr %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @lshr_sub_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.sub %2, %arg1  : vector<2xi8>
    %4 = llvm.lshr %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @lshr_sub_poison(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.undef : vector<2xi64>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi64>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<2xi64>
    %14 = llvm.srem %arg1, %0  : vector<2xi64>
    %15 = llvm.lshr %arg0, %7  : vector<2xi64>
    %16 = llvm.sub %14, %15  : vector<2xi64>
    %17 = llvm.lshr %16, %13  : vector<2xi64>
    llvm.return %17 : vector<2xi64>
  }
}
