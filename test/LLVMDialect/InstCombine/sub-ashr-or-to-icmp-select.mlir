module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @clamp255_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    %4 = llvm.or %3, %arg0  : i32
    %5 = llvm.and %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @sub_ashr_or_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    llvm.return %3 : i8
  }
  llvm.func @sub_ashr_or_i16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i16
    %2 = llvm.ashr %1, %0  : i16
    %3 = llvm.or %2, %arg0  : i16
    llvm.return %3 : i16
  }
  llvm.func @sub_ashr_or_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @sub_ashr_or_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i64
    %2 = llvm.ashr %1, %0  : i64
    %3 = llvm.or %2, %arg0  : i64
    llvm.return %3 : i64
  }
  llvm.func @neg_or_ashr_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @sub_ashr_or_i32_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw, nuw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @sub_ashr_or_i32_commute(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @neg_or_ashr_i32_commute(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.sdiv %0, %arg0  : i32
    %4 = llvm.sub %1, %3  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.ashr %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @sub_ashr_or_i32_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<4xi32>
    %2 = llvm.ashr %1, %0  : vector<4xi32>
    %3 = llvm.or %2, %arg0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @sub_ashr_or_i32_vec_nuw_nsw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw, nuw>  : vector<4xi32>
    %2 = llvm.ashr %1, %0  : vector<4xi32>
    %3 = llvm.or %2, %arg0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @neg_or_ashr_i32_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    %4 = llvm.or %3, %arg0  : vector<4xi32>
    %5 = llvm.ashr %4, %2  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @sub_ashr_or_i32_vec_commute(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<4xi32>
    %2 = llvm.ashr %1, %0  : vector<4xi32>
    %3 = llvm.or %arg0, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @neg_or_ashr_i32_vec_commute(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.sdiv %0, %arg0  : vector<4xi32>
    %5 = llvm.sub %2, %4  : vector<4xi32>
    %6 = llvm.or %4, %5  : vector<4xi32>
    %7 = llvm.ashr %6, %3  : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
  llvm.func @sub_ashr_or_i32_extra_use_sub(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @sub_ashr_or_i32_extra_use_or(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %3 : i32
  }
  llvm.func @neg_extra_use_or_ashr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %4 : i32
  }
  llvm.func @sub_ashr_or_i32_extra_use_ashr(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @sub_ashr_or_i32_no_nsw_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @neg_or_extra_use_ashr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %4 : i32
  }
  llvm.func @sub_ashr_or_i32_vec_undef1(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.sub %10, %arg0  : vector<4xi32>
    %13 = llvm.ashr %12, %11  : vector<4xi32>
    %14 = llvm.or %13, %arg0  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }
  llvm.func @sub_ashr_or_i32_vec_undef2(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<255> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.sub %0, %arg0 overflow<nsw>  : vector<4xi32>
    %13 = llvm.ashr %12, %11  : vector<4xi32>
    %14 = llvm.or %13, %arg0  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }
  llvm.func @sub_ashr_or_i32_shift_wrong_bit(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }
}
