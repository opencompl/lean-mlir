module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @positive_samevar(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.return %1 : i8
  }
  llvm.func @positive_sameconst(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.shl %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @positive_biggerlshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_biggershl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_samevar_shlnuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    llvm.return %1 : i8
  }
  llvm.func @positive_sameconst_shlnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nuw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @positive_biggerlshr_shlnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_biggershl_shlnuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_samevar_shlnsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    llvm.return %1 : i8
  }
  llvm.func @positive_sameconst_shlnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nsw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @positive_biggerlshr_shlnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_biggershl_shlnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_samevar_shlnuwnsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i8
    llvm.return %1 : i8
  }
  llvm.func @positive_sameconst_shlnuwnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @positive_biggerlshr_shlnuwnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_biggershl_shlnuwnsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_samevar_lshrexact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.return %1 : i8
  }
  llvm.func @positive_sameconst_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.shl %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @positive_biggerlshr_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_biggershl_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_samevar_shlnsw_lshrexact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    llvm.return %1 : i8
  }
  llvm.func @positive_sameconst_shlnsw_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nsw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @positive_biggerlshr_shlnsw_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_biggershl_shlnsw_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_samevar_shlnuw_lshrexact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    llvm.return %1 : i8
  }
  llvm.func @positive_sameconst_shlnuw_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nuw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @positive_biggerlshr_shlnuw_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_biggershl_shlnuw_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_samevar_shlnuwnsw_lshrexact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i8
    llvm.return %1 : i8
  }
  llvm.func @positive_sameconst_shlnuwnsw_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.shl %1, %0 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @positive_biggerlshr_shlnuwnsw_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_biggershl_shlnuwnsw_lshrexact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_samevar_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.lshr %arg0, %arg1  : vector<2xi8>
    %1 = llvm.shl %0, %arg1  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @positive_sameconst_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %arg0, %0  : vector<2xi8>
    %2 = llvm.shl %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @positive_sameconst_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.lshr %arg0, %8  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }
  llvm.func @positive_sameconst_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.lshr %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }
  llvm.func @positive_sameconst_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.lshr %arg0, %8  : vector<3xi8>
    %10 = llvm.shl %9, %8  : vector<3xi8>
    llvm.return %10 : vector<3xi8>
  }
  llvm.func @positive_biggerlshr_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @positive_biggerlshr_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.lshr %arg0, %8  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }
  llvm.func @positive_biggerlshr_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.lshr %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }
  llvm.func @positive_biggerlshr_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(3 : i8) : i8
    %10 = llvm.mlir.undef : vector<3xi8>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi8>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi8>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi8>
    %17 = llvm.lshr %arg0, %8  : vector<3xi8>
    %18 = llvm.shl %17, %16  : vector<3xi8>
    llvm.return %18 : vector<3xi8>
  }
  llvm.func @positive_biggershl_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @positive_biggershl_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<6> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.lshr %arg0, %8  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }
  llvm.func @positive_biggershl_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.lshr %arg0, %0  : vector<3xi8>
    %11 = llvm.shl %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }
  llvm.func @positive_biggershl_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(6 : i8) : i8
    %10 = llvm.mlir.undef : vector<3xi8>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi8>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi8>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi8>
    %17 = llvm.lshr %arg0, %8  : vector<3xi8>
    %18 = llvm.shl %17, %16  : vector<3xi8>
    llvm.return %18 : vector<3xi8>
  }
  llvm.func @positive_sameconst_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.call @use32(%1) : (i8) -> ()
    %2 = llvm.shl %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @positive_biggerlshr_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use32(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_biggershl_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use32(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @positive_biggerlshr_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[3, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @positive_biggerLlshr_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @negative_twovars(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg1  : i8
    %1 = llvm.shl %0, %arg2  : i8
    llvm.return %1 : i8
  }
  llvm.func @use32(i8)
  llvm.func @negative_oneuse(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg1  : i8
    llvm.call @use32(%0) : (i8) -> ()
    %1 = llvm.shl %0, %arg1  : i8
    llvm.return %1 : i8
  }
}
