module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @lshr_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %1  : i8
    %4 = llvm.add %3, %2  : i8
    %5 = llvm.shl %4, %1  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_add_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.srem %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %1  : vector<2xi8>
    %4 = llvm.add %2, %3  : vector<2xi8>
    %5 = llvm.shl %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    %5 = llvm.shl %4, %1  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_sub_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.srem %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %1  : vector<2xi8>
    %4 = llvm.sub %3, %2  : vector<2xi8>
    %5 = llvm.shl %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %1  : i8
    %4 = llvm.and %3, %2  : i8
    %5 = llvm.shl %4, %1  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_and_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.srem %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %1  : vector<2xi8>
    %4 = llvm.and %2, %3  : vector<2xi8>
    %5 = llvm.shl %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_or(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.shl %4, %1  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_or_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.srem %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %1  : vector<2xi8>
    %4 = llvm.or %3, %2  : vector<2xi8>
    %5 = llvm.shl %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_xor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %1  : i8
    %4 = llvm.xor %3, %2  : i8
    %5 = llvm.shl %4, %1  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_xor_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.srem %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %1  : vector<2xi8>
    %4 = llvm.xor %2, %3  : vector<2xi8>
    %5 = llvm.shl %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @lshr_add_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.add %1, %arg0  : i8
    %3 = llvm.shl %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @lshr_add_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.shl %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @lshr_and_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.add %3, %5  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }
  llvm.func @lshr_and_add_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<12> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.add %5, %3  : vector<2xi8>
    %7 = llvm.shl %6, %1  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }
  llvm.func @lshr_and_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.sub %3, %5  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }
  llvm.func @lshr_and_sub_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<13> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.sub %5, %3  : vector<2xi8>
    %7 = llvm.shl %6, %1  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }
  llvm.func @lshr_and_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.and %5, %3  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }
  llvm.func @lshr_and_and_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<13> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.and %3, %5  : vector<2xi8>
    %7 = llvm.shl %6, %1  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }
  llvm.func @lshr_and_or(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.or %3, %5  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }
  llvm.func @lshr_and_or_disjoint(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.or %3, %5  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }
  llvm.func @ashr_and_or_disjoint(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.ashr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.or %3, %5  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }
  llvm.func @lshr_and_or_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<13> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.or %5, %3  : vector<2xi8>
    %7 = llvm.shl %6, %1  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }
  llvm.func @lshr_and_xor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(13 : i8) : i8
    %3 = llvm.srem %arg0, %0  : i8
    %4 = llvm.lshr %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.xor %5, %3  : i8
    %7 = llvm.shl %6, %1  : i8
    llvm.return %7 : i8
  }
  llvm.func @lshr_and_xor_commute_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<13> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.xor %3, %5  : vector<2xi8>
    %7 = llvm.shl %6, %1  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }
  llvm.func @lshr_and_add_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.add %arg0, %3  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_and_add_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %arg0, %3  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_and_add_use3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.add %arg0, %3  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_and_add_use4(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %arg0, %3  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_and_add_use5(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %arg0, %3  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_and_add_use6(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.add %arg0, %3  : i8
    %5 = llvm.shl %4, %0  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_add_shl_v2i8_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
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
    %12 = llvm.lshr %arg1, %6  : vector<2xi8>
    %13 = llvm.add %12, %arg0  : vector<2xi8>
    %14 = llvm.shl %13, %11  : vector<2xi8>
    llvm.return %14 : vector<2xi8>
  }
  llvm.func @lshr_add_shl_v2i8_nonuniform(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %arg1, %0  : vector<2xi8>
    %2 = llvm.add %1, %arg0  : vector<2xi8>
    %3 = llvm.shl %2, %0  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @lshr_add_and_shl(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %arg1, %3  : i32
    %5 = llvm.shl %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @lshr_add_and_shl_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<127> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %arg1, %3  : vector<2xi32>
    %5 = llvm.shl %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @lshr_add_and_shl_v2i32_undef(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<127> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %1, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.lshr %arg0, %6  : vector<2xi32>
    %14 = llvm.and %13, %7  : vector<2xi32>
    %15 = llvm.add %arg1, %14  : vector<2xi32>
    %16 = llvm.shl %15, %12  : vector<2xi32>
    llvm.return %16 : vector<2xi32>
  }
  llvm.func @lshr_add_and_shl_v2i32_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[127, 255]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %arg1, %3  : vector<2xi32>
    %5 = llvm.shl %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @shl_add_and_lshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %arg1  : i32
    %5 = llvm.shl %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @shl_add_and_lshr_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %arg1  : vector<2xi32>
    %5 = llvm.shl %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @shl_add_and_lshr_v2i32_undef(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(8 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.lshr %arg0, %6  : vector<2xi32>
    %14 = llvm.and %13, %12  : vector<2xi32>
    %15 = llvm.add %14, %arg1  : vector<2xi32>
    %16 = llvm.shl %15, %6  : vector<2xi32>
    llvm.return %16 : vector<2xi32>
  }
  llvm.func @shl_add_and_lshr_v2i32_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[8, 9]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %arg1  : vector<2xi32>
    %5 = llvm.shl %4, %0  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test_FoldShiftByConstant_CreateSHL(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, -1, 0, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_FoldShiftByConstant_CreateSHL2(%arg0: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<[0, -1, 0, -1, 0, -1, 0, -1]> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.mlir.constant(dense<5> : vector<8xi16>) : vector<8xi16>
    %2 = llvm.mul %arg0, %0  : vector<8xi16>
    %3 = llvm.shl %2, %1  : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }
  llvm.func @test_FoldShiftByConstant_CreateAnd(%arg0: vector<16xi8>) -> vector<16xi8> {
    %0 = llvm.mlir.constant(dense<5> : vector<16xi8>) : vector<16xi8>
    %1 = llvm.ashr %arg0, %0  : vector<16xi8>
    %2 = llvm.add %arg0, %1  : vector<16xi8>
    %3 = llvm.shl %2, %0  : vector<16xi8>
    llvm.return %3 : vector<16xi8>
  }
}
