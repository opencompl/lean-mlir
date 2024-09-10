module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @shl_C1_add_A_C2_i32(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.shl %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.ashr %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @lshr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.shl %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @shl_C1_add_A_C2_v4i32(%arg0: vector<4xi16>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.zext %arg0 : vector<4xi16> to vector<4xi32>
    %3 = llvm.add %2, %0  : vector<4xi32>
    %4 = llvm.shl %1, %3  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @ashr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    %5 = llvm.ashr %2, %4  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @lshr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    %5 = llvm.lshr %2, %4  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @shl_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.shl %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }
  llvm.func @ashr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.ashr %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }
  llvm.func @lshr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.lshr %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }
  llvm.func @shl_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_add_nuw(%arg0: vector<2xi12>) -> vector<2xi12> {
    %0 = llvm.mlir.constant(1 : i12) : i12
    %1 = llvm.mlir.constant(5 : i12) : i12
    %2 = llvm.mlir.constant(dense<[5, 1]> : vector<2xi12>) : vector<2xi12>
    %3 = llvm.mlir.constant(42 : i12) : i12
    %4 = llvm.mlir.constant(6 : i12) : i12
    %5 = llvm.mlir.constant(dense<[6, 42]> : vector<2xi12>) : vector<2xi12>
    %6 = llvm.add %arg0, %2 overflow<nuw>  : vector<2xi12>
    %7 = llvm.lshr %5, %6  : vector<2xi12>
    llvm.return %7 : vector<2xi12>
  }
  llvm.func @ashr_add_nuw(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-6 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nuw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.shl %0, %1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @shl_nsw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_exact_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_exact_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_exact_add_positive_shift_positive(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_exact_add_big_negative_offset(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_exact_add_negative_shift_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_add_negative_shift_no_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_exact_add_negative_shift_positive(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_exact_add_negative_shift_positive_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.lshr %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @lshr_exact_add_negative_shift_positive_vec(%arg0: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(-7 : i9) : i9
    %1 = llvm.mlir.constant(dense<-7> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(2 : i9) : i9
    %3 = llvm.mlir.constant(dense<2> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.add %arg0, %1  : vector<2xi9>
    %5 = llvm.lshr %3, %4  : vector<2xi9>
    llvm.return %5 : vector<2xi9>
  }
  llvm.func @lshr_exact_add_negative_shift_lzcnt(%arg0: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(-7 : i9) : i9
    %1 = llvm.mlir.constant(dense<-7> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(4 : i9) : i9
    %3 = llvm.mlir.constant(dense<4> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.add %arg0, %1  : vector<2xi9>
    %5 = llvm.lshr %3, %4  : vector<2xi9>
    llvm.return %5 : vector<2xi9>
  }
  llvm.func @ashr_exact_add_negative_shift_no_trailing_zeros(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(-112 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.ashr %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @ashr_exact_add_big_negative_offset(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_add_negative_shift_no_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_exact_add_negative_shift_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_exact_add_negative_shift_negative_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.ashr %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @ashr_exact_add_negative_shift_negative_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(-5 : i7) : i7
    %1 = llvm.mlir.constant(dense<-5> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(-2 : i7) : i7
    %3 = llvm.mlir.constant(dense<-2> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.add %arg0, %1  : vector<2xi7>
    %5 = llvm.ashr %3, %4  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }
  llvm.func @ashr_exact_add_negative_leading_ones_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(-5 : i7) : i7
    %1 = llvm.mlir.constant(dense<-5> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(-4 : i7) : i7
    %3 = llvm.mlir.constant(dense<-4> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.add %arg0, %1  : vector<2xi7>
    %5 = llvm.ashr %3, %4  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }
  llvm.func @shl_nsw_add_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nuw_add_negative_splat_uses(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<12> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %3 = llvm.shl %1, %2 overflow<nuw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @shl_nsw_add_negative_invalid_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nsw_add_positive_invalid_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nsw_add_negative_invalid_constant2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nsw_add_negative_invalid_constant3(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.add %arg0, %0  : i4
    %3 = llvm.shl %1, %2 overflow<nsw>  : i4
    llvm.return %3 : i4
  }
  llvm.func @lshr_2_add_zext_basic(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.mlir.constant(1 : i2) : i2
    %1 = llvm.zext %arg0 : i1 to i2
    %2 = llvm.zext %arg1 : i1 to i2
    %3 = llvm.add %1, %2  : i2
    %4 = llvm.lshr %3, %0  : i2
    llvm.return %4 : i2
  }
  llvm.func @ashr_2_add_zext_basic(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.mlir.constant(1 : i2) : i2
    %1 = llvm.zext %arg0 : i1 to i2
    %2 = llvm.zext %arg1 : i1 to i2
    %3 = llvm.add %1, %2  : i2
    %4 = llvm.ashr %3, %0  : i2
    llvm.return %4 : i2
  }
  llvm.func @lshr_16_add_zext_basic(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.lshr %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @lshr_16_add_zext_basic_multiuse(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.lshr %3, %0  : i32
    %5 = llvm.or %4, %1  : i32
    llvm.return %5 : i32
  }
  llvm.func @lshr_16_add_known_16_leading_zeroes(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.add %2, %3  : i32
    %5 = llvm.lshr %4, %1  : i32
    llvm.return %5 : i32
  }
  llvm.func @lshr_16_add_not_known_16_leading_zeroes(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(131071 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.add %3, %4  : i32
    %6 = llvm.lshr %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @lshr_32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.lshr %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @lshr_32_add_zext_basic_multiuse(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.lshr %3, %0  : i64
    %5 = llvm.or %4, %2  : i64
    llvm.return %5 : i64
  }
  llvm.func @lshr_31_i32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.lshr %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @lshr_33_i32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(33 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.lshr %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @lshr_16_to_64_add_zext_basic(%arg0: i16, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.zext %arg0 : i16 to i64
    %2 = llvm.zext %arg1 : i16 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.lshr %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @lshr_32_add_known_32_leading_zeroes(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.and %arg1, %0  : i64
    %4 = llvm.add %2, %3  : i64
    %5 = llvm.lshr %4, %1  : i64
    llvm.return %5 : i64
  }
  llvm.func @lshr_32_add_not_known_32_leading_zeroes(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8589934591 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.and %arg1, %1  : i64
    %5 = llvm.add %3, %4  : i64
    %6 = llvm.lshr %5, %2  : i64
    llvm.return %6 : i64
  }
  llvm.func @ashr_16_add_zext_basic(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.lshr %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.ashr %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @ashr_16_to_64_add_zext_basic(%arg0: i16, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.zext %arg0 : i16 to i64
    %2 = llvm.zext %arg1 : i16 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.ashr %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @lshr_32_add_zext_trunc(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.lshr %3, %0  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.add %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @add3_i96(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.undef : vector<3xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.extractelement %arg0[%0 : i64] : vector<3xi32>
    %9 = llvm.zext %8 : i32 to i64
    %10 = llvm.extractelement %arg1[%0 : i64] : vector<3xi32>
    %11 = llvm.zext %10 : i32 to i64
    %12 = llvm.add %11, %9 overflow<nsw, nuw>  : i64
    %13 = llvm.extractelement %arg0[%1 : i64] : vector<3xi32>
    %14 = llvm.zext %13 : i32 to i64
    %15 = llvm.extractelement %arg1[%1 : i64] : vector<3xi32>
    %16 = llvm.zext %15 : i32 to i64
    %17 = llvm.add %16, %14 overflow<nsw, nuw>  : i64
    %18 = llvm.lshr %12, %2  : i64
    %19 = llvm.add %17, %18 overflow<nsw, nuw>  : i64
    %20 = llvm.extractelement %arg0[%3 : i64] : vector<3xi32>
    %21 = llvm.extractelement %arg1[%3 : i64] : vector<3xi32>
    %22 = llvm.add %21, %20  : i32
    %23 = llvm.lshr %19, %2  : i64
    %24 = llvm.trunc %23 : i64 to i32
    %25 = llvm.add %22, %24  : i32
    %26 = llvm.trunc %12 : i64 to i32
    %27 = llvm.insertelement %26, %4[%5 : i32] : vector<3xi32>
    %28 = llvm.trunc %19 : i64 to i32
    %29 = llvm.insertelement %28, %27[%6 : i32] : vector<3xi32>
    %30 = llvm.insertelement %25, %29[%7 : i32] : vector<3xi32>
    llvm.return %30 : vector<3xi32>
  }
  llvm.func @shl_fold_or_disjoint_cnt(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.shl %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @ashr_fold_or_disjoint_cnt(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.ashr %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @lshr_fold_or_disjoint_cnt_out_of_bounds(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 8]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
}
