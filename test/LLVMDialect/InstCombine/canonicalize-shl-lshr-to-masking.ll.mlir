module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @positive_samevar(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.return %1 : i32
  }
  llvm.func @positive_sameconst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @positive_biggerShl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @positive_biggerLshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @positive_biggerLshr_lshrexact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @positive_samevar_shlnuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.return %1 : i32
  }
  llvm.func @positive_sameconst_shlnuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @positive_biggerShl_shlnuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @positive_biggerLshr_shlnuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @positive_biggerLshr_shlnuw_lshrexact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @positive_samevar_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.shl %arg0, %arg1  : vector<2xi32>
    %1 = llvm.lshr %0, %arg1  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @positive_sameconst_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @positive_sameconst_vec_undef0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.shl %arg0, %8  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }
  llvm.func @positive_sameconst_vec_undef1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.shl %arg0, %0  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }
  llvm.func @positive_sameconst_vec_undef2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.shl %arg0, %8  : vector<3xi32>
    %10 = llvm.lshr %9, %8  : vector<3xi32>
    llvm.return %10 : vector<3xi32>
  }
  llvm.func @positive_biggerShl_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @positive_biggerShl_vec_undef0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.shl %arg0, %8  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }
  llvm.func @positive_biggerShl_vec_undef1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<10> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.shl %arg0, %0  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }
  llvm.func @positive_biggerShl_vec_undef2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(5 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.shl %arg0, %8  : vector<3xi32>
    %18 = llvm.lshr %17, %16  : vector<3xi32>
    llvm.return %18 : vector<3xi32>
  }
  llvm.func @positive_biggerLshr_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @positive_biggerLshr_vec_undef0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<10> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.shl %arg0, %8  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }
  llvm.func @positive_biggerLshr_vec_undef1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.shl %arg0, %0  : vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }
  llvm.func @positive_biggerLshr_vec_undef2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(10 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.shl %arg0, %8  : vector<3xi32>
    %18 = llvm.lshr %17, %16  : vector<3xi32>
    llvm.return %18 : vector<3xi32>
  }
  llvm.func @positive_sameconst_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @positive_biggerShl_shlnuw_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @positive_biggerLshr_shlnuw_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @positive_biggerShl_multiuse_extrainstr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @positive_biggerLshr_multiuse_extrainstr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @positive_biggerShl_vec_nonsplat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[5, 10]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @positive_biggerLshl_vec_nonsplat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[5, 10]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @negative_twovars(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    llvm.return %1 : i32
  }
  llvm.func @use32(i32)
  llvm.func @negative_oneuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.return %1 : i32
  }
}
