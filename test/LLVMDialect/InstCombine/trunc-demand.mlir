module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use6(i6)
  llvm.func @use8(i8)
  llvm.func @trunc_lshr(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(14 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }
  llvm.func @trunc_lshr_exact_mask(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(15 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }
  llvm.func @trunc_lshr_big_mask(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(31 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }
  llvm.func @trunc_lshr_use1(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(15 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }
  llvm.func @trunc_lshr_use2(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(15 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    llvm.call @use6(%3) : (i6) -> ()
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }
  llvm.func @trunc_lshr_vec_splat(%arg0: vector<2xi16>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(1 : i7) : i7
    %2 = llvm.mlir.constant(dense<1> : vector<2xi7>) : vector<2xi7>
    %3 = llvm.lshr %arg0, %0  : vector<2xi16>
    %4 = llvm.trunc %3 : vector<2xi16> to vector<2xi7>
    %5 = llvm.and %4, %2  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }
  llvm.func @trunc_lshr_vec_splat_exact_mask(%arg0: vector<2xi16>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(1 : i7) : i7
    %2 = llvm.mlir.constant(dense<1> : vector<2xi7>) : vector<2xi7>
    %3 = llvm.lshr %arg0, %0  : vector<2xi16>
    %4 = llvm.trunc %3 : vector<2xi16> to vector<2xi7>
    %5 = llvm.and %4, %2  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }
  llvm.func @trunc_lshr_big_shift(%arg0: vector<2xi16>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(1 : i7) : i7
    %2 = llvm.mlir.constant(dense<1> : vector<2xi7>) : vector<2xi7>
    %3 = llvm.lshr %arg0, %0  : vector<2xi16>
    %4 = llvm.trunc %3 : vector<2xi16> to vector<2xi7>
    %5 = llvm.and %4, %2  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }
  llvm.func @or_trunc_lshr(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.or %3, %1  : i6
    llvm.return %4 : i6
  }
  llvm.func @or_trunc_lshr_more(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.or %3, %1  : i6
    llvm.return %4 : i6
  }
  llvm.func @or_trunc_lshr_small_mask(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.or %3, %1  : i6
    llvm.return %4 : i6
  }
}
