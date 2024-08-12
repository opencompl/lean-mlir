module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g() {addr_space = 0 : i32, alignment = 8 : i64} : i8
  llvm.func @use8(i8)
  llvm.func @use32(i32)
  llvm.func @pr12967() {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.lshr %4, %2  : i32
    llvm.br ^bb1(%5 : i32)
  }
  llvm.func @pr26760() {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.shl %4, %2  : i32
    llvm.br ^bb1(%5 : i32)
  }
  llvm.func @pr8547(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.constant(24 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.store %4, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.shl %4, %1  : i32
    %6 = llvm.lshr %5, %2  : i32
    %7 = llvm.icmp "eq" %6, %0 : i32
    llvm.cond_br %7, ^bb1(%3 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %6 : i32
  }
  llvm.func @shl_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(28 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_shl_splat_vec(%arg0: vector<2xi33>) -> vector<2xi33> {
    %0 = llvm.mlir.constant(5 : i33) : i33
    %1 = llvm.mlir.constant(dense<5> : vector<2xi33>) : vector<2xi33>
    %2 = llvm.mlir.constant(28 : i33) : i33
    %3 = llvm.mlir.constant(dense<28> : vector<2xi33>) : vector<2xi33>
    %4 = llvm.shl %arg0, %1  : vector<2xi33>
    %5 = llvm.shl %4, %3  : vector<2xi33>
    llvm.return %5 : vector<2xi33>
  }
  llvm.func @shl_shl_vec(%arg0: vector<2xi33>) -> vector<2xi33> {
    %0 = llvm.mlir.constant(5 : i33) : i33
    %1 = llvm.mlir.constant(6 : i33) : i33
    %2 = llvm.mlir.constant(dense<[6, 5]> : vector<2xi33>) : vector<2xi33>
    %3 = llvm.mlir.constant(28 : i33) : i33
    %4 = llvm.mlir.constant(27 : i33) : i33
    %5 = llvm.mlir.constant(dense<[27, 28]> : vector<2xi33>) : vector<2xi33>
    %6 = llvm.shl %arg0, %2  : vector<2xi33>
    %7 = llvm.shl %6, %5  : vector<2xi33>
    llvm.return %7 : vector<2xi33>
  }
  llvm.func @lshr_lshr(%arg0: i232) -> i232 {
    %0 = llvm.mlir.constant(231 : i232) : i232
    %1 = llvm.mlir.constant(1 : i232) : i232
    %2 = llvm.lshr %arg0, %0  : i232
    %3 = llvm.lshr %2, %1  : i232
    llvm.return %3 : i232
  }
  llvm.func @lshr_lshr_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<28> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @lshr_lshr_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[29, 28]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @shl_trunc_bigger_lshr(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_trunc_smaller_lshr(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_trunc_bigger_ashr(%arg0: i32) -> i24 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(3 : i24) : i24
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i24
    %4 = llvm.shl %3, %1  : i24
    llvm.return %4 : i24
  }
  llvm.func @shl_trunc_smaller_ashr(%arg0: i32) -> i24 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(13 : i24) : i24
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i24
    %4 = llvm.shl %3, %1  : i24
    llvm.return %4 : i24
  }
  llvm.func @shl_trunc_bigger_shl(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_trunc_smaller_shl(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_trunc_bigger_lshr_use1(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_trunc_smaller_lshr_use1(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_trunc_bigger_lshr_use2(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_trunc_smaller_lshr_use2(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @ashr_ashr_constants_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_ashr_constants_vec(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[33, -2, -128]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<[3, -1, 7]> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.ashr %0, %arg0  : vector<3xi8>
    %3 = llvm.ashr %2, %1  : vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @lshr_lshr_constants_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_lshr_constants_vec(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[33, -2, 1]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<[3, -1, 7]> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.lshr %0, %arg0  : vector<3xi8>
    %3 = llvm.lshr %2, %1  : vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shl_shl_constants_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2013265920 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_shl_constants_vec(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[33, -2, -128]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<[3, -1, 7]> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.shl %0, %arg0  : vector<3xi8>
    %3 = llvm.shl %2, %1  : vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }
  llvm.func @shl_shl_constants_div(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.udiv %arg0, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_lshr_constants(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_shl_constants(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_ashr_constants(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @lshr_shl_constants(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_ashr_constants(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_lshr_constants(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_lshr_demand1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(40 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-32 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.lshr %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_ashr_demand2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(40 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-32 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.ashr %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_lshr_demand3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(40 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-64 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.lshr %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_lshr_demand4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(44 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-32 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.lshr %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_lshr_demand5(%arg0: vector<2xi8>) -> vector<2xi6> {
    %0 = llvm.mlir.constant(dense<-108> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg0  : vector<2xi8>
    %3 = llvm.lshr %2, %1  : vector<2xi8>
    %4 = llvm.trunc %3 : vector<2xi8> to vector<2xi6>
    llvm.return %4 : vector<2xi6>
  }
  llvm.func @shl_lshr_demand5_undef_left(%arg0: vector<2xi8>) -> vector<2xi6> {
    %0 = llvm.mlir.constant(-108 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.shl %6, %arg0  : vector<2xi8>
    %9 = llvm.lshr %8, %7  : vector<2xi8>
    %10 = llvm.trunc %9 : vector<2xi8> to vector<2xi6>
    llvm.return %10 : vector<2xi6>
  }
  llvm.func @shl_lshr_demand5_undef_right(%arg0: vector<2xi8>) -> vector<2xi6> {
    %0 = llvm.mlir.constant(dense<-108> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.shl %0, %arg0  : vector<2xi8>
    %9 = llvm.lshr %8, %7  : vector<2xi8>
    %10 = llvm.trunc %9 : vector<2xi8> to vector<2xi6>
    llvm.return %10 : vector<2xi6>
  }
  llvm.func @shl_lshr_demand5_nonuniform_vec_left(%arg0: vector<2xi8>) -> vector<2xi6> {
    %0 = llvm.mlir.constant(dense<-108> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg0  : vector<2xi8>
    %3 = llvm.lshr %2, %1  : vector<2xi8>
    %4 = llvm.trunc %3 : vector<2xi8> to vector<2xi6>
    llvm.return %4 : vector<2xi6>
  }
  llvm.func @shl_lshr_demand5_nonuniform_vec_right(%arg0: vector<2xi8>) -> vector<2xi6> {
    %0 = llvm.mlir.constant(dense<[-108, -112]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg0  : vector<2xi8>
    %3 = llvm.lshr %2, %1  : vector<2xi8>
    %4 = llvm.trunc %3 : vector<2xi8> to vector<2xi6>
    llvm.return %4 : vector<2xi6>
  }
  llvm.func @shl_lshr_demand5_nonuniform_vec_both(%arg0: vector<2xi8>) -> vector<2xi6> {
    %0 = llvm.mlir.constant(dense<[-104, -108]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[3, 2]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg0  : vector<2xi8>
    %3 = llvm.lshr %2, %1  : vector<2xi8>
    %4 = llvm.trunc %3 : vector<2xi8> to vector<2xi6>
    llvm.return %4 : vector<2xi6>
  }
  llvm.func @shl_lshr_demand6(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-32624 : i16) : i16
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(4094 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @lshr_shl_demand1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(28 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_shl_demand2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(28 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(-16 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.and %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_shl_demand3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(28 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @lshr_shl_demand4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(60 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_shl_demand5(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<45> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<108> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %0, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_shl_demand5_undef_left(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<45> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<108> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.lshr %0, %arg0  : vector<2xi8>
    %10 = llvm.shl %9, %7  : vector<2xi8>
    %11 = llvm.and %10, %8  : vector<2xi8>
    llvm.return %11 : vector<2xi8>
  }
  llvm.func @lshr_shl_demand5_undef_right(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(45 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.mlir.constant(dense<108> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.lshr %6, %arg0  : vector<2xi8>
    %10 = llvm.shl %9, %7  : vector<2xi8>
    %11 = llvm.and %10, %8  : vector<2xi8>
    llvm.return %11 : vector<2xi8>
  }
  llvm.func @lshr_shl_demand5_nonuniform_vec_left(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<45> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<108> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %0, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_shl_demand5_nonuniform_vec_right(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[45, 13]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<108> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %0, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_shl_demand5_nonuniform_vec_both(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[45, 13]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[-4, -16]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %0, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @ashr_ashr_constexpr() -> i64 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.ashr %1, %2  : i64
    %5 = llvm.ashr %4, %3  : i64
    llvm.return %5 : i64
  }
}
