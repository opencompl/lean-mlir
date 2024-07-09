module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @use64(i64)
  llvm.func @low_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<4xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }
  llvm.func @high_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<4xi16>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }
  llvm.func @wrong_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<4xi16>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }
  llvm.func @low_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }
  llvm.func @high_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }
  llvm.func @wrong_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }
  llvm.func @low_index_shorter_length_poison_basevec(%arg0: i64) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @wrong_index_shorter_length_poison_basevec(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }
  llvm.func @wrong_width_low_index_shorter_length_poison_basevec(%arg0: i65) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i65 to i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }
  llvm.func @low_index_shorter_length_poison_basevec_extra_use(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.trunc %arg0 : i64 to i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }
  llvm.func @lshr_same_length_poison_basevec_le(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }
  llvm.func @lshr_same_length_poison_basevec_be(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }
  llvm.func @lshr_same_length_poison_basevec_both_endian(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }
  llvm.func @lshr_wrong_index_same_length_poison_basevec(%arg0: i64) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }
  llvm.func @lshr_longer_length_poison_basevec_le(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.poison : vector<8xi16>
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<8xi16>
    llvm.return %5 : vector<8xi16>
  }
  llvm.func @lshr_longer_length_poison_basevec_be(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<8xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<8xi16>
    llvm.return %5 : vector<8xi16>
  }
  llvm.func @lshr_wrong_index_longer_length_poison_basevec(%arg0: i64) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.poison : vector<8xi16>
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<8xi16>
    llvm.return %5 : vector<8xi16>
  }
  llvm.func @lshr_shorter_length_poison_basevec_le(%arg0: i64) -> vector<2xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.poison : vector<2xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<2xi16>
    llvm.return %5 : vector<2xi16>
  }
  llvm.func @lshr_shorter_length_poison_basevec_be(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }
  llvm.func @lshr_wrong_index_shorter_length_poison_basevec(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }
  llvm.func @lshr_wrong_shift_shorter_length_poison_basevec(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(57 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }
  llvm.func @lshr_shorter_length_poison_basevec_be_extra_use(%arg0: i64) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }
  llvm.func @low_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }
  llvm.func @high_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }
  llvm.func @wrong_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }
  llvm.func @low_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }
  llvm.func @high_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }
  llvm.func @wrong_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }
  llvm.func @low_index_shorter_length_basevec(%arg0: i64, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }
  llvm.func @wrong_index_shorter_length_basevec(%arg0: i64, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.trunc %arg0 : i64 to i8
    %2 = llvm.insertelement %1, %arg1[%0 : i64] : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @lshr_same_length_basevec_le(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }
  llvm.func @lshr_same_length_basevec_be(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }
  llvm.func @lshr_same_length_basevec_both_endian(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }
  llvm.func @lshr_wrong_index_same_length_basevec(%arg0: i64, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }
  llvm.func @lshr_longer_length_basevec_le(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<8xi16>
    llvm.return %4 : vector<8xi16>
  }
  llvm.func @lshr_longer_length_basevec_be(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<8xi16>
    llvm.return %4 : vector<8xi16>
  }
  llvm.func @lshr_wrong_index_longer_length_basevec(%arg0: i64, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<8xi16>
    llvm.return %4 : vector<8xi16>
  }
  llvm.func @lshr_shorter_length_basevec_le(%arg0: i64, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i16
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }
  llvm.func @lshr_shorter_length_basevec_be(%arg0: i64, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i8
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
  llvm.func @lshr_wrong_index_shorter_length_basevec(%arg0: i64, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i8
    %4 = llvm.insertelement %3, %arg1[%1 : i64] : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }
}
