module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @shl_and_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(88 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.and %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_and_and_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.constant(88 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.shl %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.and %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @shl_add_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_add_add_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_and_and_fail2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(88 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg1  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.and %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_and_or(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[44, 99]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %0  : vector<2xi8>
    %4 = llvm.and %2, %1  : vector<2xi8>
    %5 = llvm.or %3, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_and_or_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[44, 99]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.or %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }
  llvm.func @shl_and_xor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.and %2, %1  : i8
    %5 = llvm.xor %3, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_and_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(119 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_xor_add_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(119 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_or_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-58 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.or %2, %1  : i8
    %5 = llvm.and %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_or_or_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-58 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_xor_and(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(44 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.shl %arg0, %6  : vector<2xi8>
    %14 = llvm.shl %arg1, %6  : vector<2xi8>
    %15 = llvm.xor %14, %12  : vector<2xi8>
    %16 = llvm.and %15, %13  : vector<2xi8>
    llvm.return %16 : vector<2xi8>
  }
  llvm.func @shl_xor_and_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.undef : vector<2xi8>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xi8>
    %12 = llvm.mlir.constant(44 : i8) : i8
    %13 = llvm.mlir.undef : vector<2xi8>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %12, %13[%14 : i32] : vector<2xi8>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %0, %15[%16 : i32] : vector<2xi8>
    %18 = llvm.shl %arg0, %6  : vector<2xi8>
    %19 = llvm.shl %arg1, %11  : vector<2xi8>
    %20 = llvm.xor %19, %17  : vector<2xi8>
    %21 = llvm.and %18, %20  : vector<2xi8>
    llvm.return %21 : vector<2xi8>
  }
  llvm.func @lshr_or_or_no_const(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg2  : i8
    %1 = llvm.lshr %arg1, %arg2  : i8
    %2 = llvm.or %1, %arg3  : i8
    %3 = llvm.or %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @lshr_or_or_no_const_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2  : i8
    %1 = llvm.lshr %arg1, %arg2  : i8
    %2 = llvm.or %1, %arg3  : i8
    %3 = llvm.or %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @shl_xor_xor_no_const(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2  : i8
    %1 = llvm.shl %arg1, %arg2  : i8
    %2 = llvm.xor %1, %arg3  : i8
    %3 = llvm.xor %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @shl_xor_and_no_const_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2  : i8
    %1 = llvm.shl %arg1, %arg2  : i8
    %2 = llvm.xor %1, %arg3  : i8
    %3 = llvm.and %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @shl_and_and_no_const(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.shl %arg0, %arg2  : vector<2xi8>
    %1 = llvm.shl %arg1, %arg2  : vector<2xi8>
    %2 = llvm.and %1, %arg3  : vector<2xi8>
    %3 = llvm.and %0, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @shl_add_add_no_const(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2  : i8
    %1 = llvm.shl %arg1, %arg2  : i8
    %2 = llvm.add %1, %arg3  : i8
    %3 = llvm.add %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @lshr_add_add_no_const_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg2  : i8
    %1 = llvm.lshr %arg1, %arg2  : i8
    %2 = llvm.add %1, %arg3  : i8
    %3 = llvm.add %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @lshr_add_and(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %0  : vector<2xi8>
    %4 = llvm.add %3, %1  : vector<2xi8>
    %5 = llvm.and %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_add_or_fail_dif_masks(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.lshr %arg0, %0  : vector<2xi8>
    %10 = llvm.lshr %arg1, %7  : vector<2xi8>
    %11 = llvm.add %10, %8  : vector<2xi8>
    %12 = llvm.and %9, %11  : vector<2xi8>
    llvm.return %12 : vector<2xi8>
  }
  llvm.func @shl_or_or_good_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[18, 24]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %0  : vector<2xi8>
    %4 = llvm.or %3, %1  : vector<2xi8>
    %5 = llvm.or %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @shl_or_or_fail_bad_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[19, 24]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %0  : vector<2xi8>
    %4 = llvm.or %3, %1  : vector<2xi8>
    %5 = llvm.or %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_xor_or_good_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_xor_or_fail_bad_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_or_xor_good_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %0  : vector<2xi8>
    %4 = llvm.or %3, %1  : vector<2xi8>
    %5 = llvm.xor %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_or_xor_fail_bad_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[7, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %0  : vector<2xi8>
    %4 = llvm.or %3, %1  : vector<2xi8>
    %5 = llvm.xor %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @shl_xor_xor_good_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(88 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.xor %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_xor_xor_bad_mask_distribute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-68 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.xor %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_add_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.and %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_and_add_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_add_or_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_add_xor_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.xor %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_and_add(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-67, 123]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %0  : vector<2xi8>
    %4 = llvm.and %2, %1  : vector<2xi8>
    %5 = llvm.add %3, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_or_add_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-67, 123]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %0  : vector<2xi8>
    %4 = llvm.or %2, %1  : vector<2xi8>
    %5 = llvm.add %3, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @shl_add_and_fail_mismatch_shift(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.and %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @and_ashr_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @and_ashr_not_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @and_ashr_not_fail_lshr_ashr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @and_ashr_not_fail_ashr_lshr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.lshr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @and_ashr_not_fail_invalid_xor_constant(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @and_ashr_not_vec(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.and %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
  llvm.func @and_ashr_not_vec_commuted(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.and %3, %1  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
  llvm.func @and_ashr_not_vec_poison_1(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %12 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %13 = llvm.xor %12, %10  : vector<4xi8>
    %14 = llvm.and %11, %13  : vector<4xi8>
    llvm.return %14 : vector<4xi8>
  }
  llvm.func @and_ashr_not_vec_poison_2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.and %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
  llvm.func @or_ashr_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_ashr_not_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_ashr_not_fail_lshr_ashr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_ashr_not_fail_ashr_lshr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.lshr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_ashr_not_fail_invalid_xor_constant(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_ashr_not_vec(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.or %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
  llvm.func @or_ashr_not_vec_commuted(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.or %3, %1  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
  llvm.func @or_ashr_not_vec_poison_1(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %12 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %13 = llvm.xor %12, %10  : vector<4xi8>
    %14 = llvm.or %11, %13  : vector<4xi8>
    llvm.return %14 : vector<4xi8>
  }
  llvm.func @or_ashr_not_vec_poison_2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.or %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
  llvm.func @xor_ashr_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.xor %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @xor_ashr_not_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @xor_ashr_not_fail_lshr_ashr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.xor %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @xor_ashr_not_fail_ashr_lshr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.lshr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.xor %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @xor_ashr_not_fail_invalid_xor_constant(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.xor %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @xor_ashr_not_vec(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.xor %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
  llvm.func @xor_ashr_not_vec_commuted(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.xor %3, %1  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
  llvm.func @xor_ashr_not_vec_poison_1(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %12 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %13 = llvm.xor %12, %10  : vector<4xi8>
    %14 = llvm.xor %11, %13  : vector<4xi8>
    llvm.return %14 : vector<4xi8>
  }
  llvm.func @xor_ashr_not_vec_poison_2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.xor %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
  llvm.func @binop_ashr_not_fail_invalid_binop(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.add %1, %3  : i8
    llvm.return %4 : i8
  }
}
