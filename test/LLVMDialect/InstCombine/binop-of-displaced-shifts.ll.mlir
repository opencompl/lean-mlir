module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @shl_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @lshr_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @ashr_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = llvm.ashr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.ashr %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @shl_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.xor %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @lshr_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.xor %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @ashr_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-64 : i8) : i8
    %3 = llvm.ashr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.ashr %2, %4  : i8
    %6 = llvm.xor %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @shl_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(8 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.and %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @lshr_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(64 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.and %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @ashr_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = llvm.ashr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.ashr %2, %4  : i8
    %6 = llvm.and %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @shl_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.add %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @lshr_add_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.add %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @ashr_add_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.add %arg0, %1  : i8
    %4 = llvm.ashr %0, %3  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @shl_or_commuted(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %5, %3  : i8
    llvm.return %6 : i8
  }
  llvm.func @shl_or_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg0  : vector<2xi8>
    %4 = llvm.add %arg0, %1  : vector<2xi8>
    %5 = llvm.shl %2, %4  : vector<2xi8>
    %6 = llvm.or %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }
  llvm.func @shl_or_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[3, 7]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg0  : vector<2xi8>
    %4 = llvm.add %arg0, %1  : vector<2xi8>
    %5 = llvm.shl %2, %4  : vector<2xi8>
    %6 = llvm.or %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }
  llvm.func @shl_or_poison_in_add(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.shl %0, %arg0  : vector<2xi8>
    %10 = llvm.add %arg0, %7  : vector<2xi8>
    %11 = llvm.shl %8, %10  : vector<2xi8>
    %12 = llvm.or %9, %11  : vector<2xi8>
    llvm.return %12 : vector<2xi8>
  }
  llvm.func @shl_or_poison_in_shift1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.shl %6, %arg0  : vector<2xi8>
    %10 = llvm.add %arg0, %7  : vector<2xi8>
    %11 = llvm.shl %8, %10  : vector<2xi8>
    %12 = llvm.or %9, %11  : vector<2xi8>
    llvm.return %12 : vector<2xi8>
  }
  llvm.func @shl_or_poison_in_shift2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.constant(3 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.shl %0, %arg0  : vector<2xi8>
    %10 = llvm.add %arg0, %1  : vector<2xi8>
    %11 = llvm.shl %8, %10  : vector<2xi8>
    %12 = llvm.or %9, %11  : vector<2xi8>
    llvm.return %12 : vector<2xi8>
  }
  llvm.func @use(i8)
  llvm.func @shl_or_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @mismatched_shifts(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @mismatched_ops(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @add_out_of_range(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @shl_or_non_splat_out_of_range(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[1, 32]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[3, 7]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg0  : vector<2xi8>
    %4 = llvm.add %arg0, %1  : vector<2xi8>
    %5 = llvm.shl %2, %4  : vector<2xi8>
    %6 = llvm.or %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }
  llvm.func @shl_or_with_or_disjoint_instead_of_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.or %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @shl_or_with_or_instead_of_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.or %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }
}
