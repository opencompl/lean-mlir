module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @neg_or_lshr_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @neg_or_lshr_i32_commute(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.sdiv %0, %arg0  : i32
    %4 = llvm.sub %1, %3  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.lshr %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @neg_or_lshr_i32_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    %4 = llvm.or %3, %arg0  : vector<4xi32>
    %5 = llvm.lshr %4, %2  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @neg_or_lshr_i32_vec_commute(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.sdiv %0, %arg0  : vector<4xi32>
    %5 = llvm.sub %2, %4  : vector<4xi32>
    %6 = llvm.or %4, %5  : vector<4xi32>
    %7 = llvm.lshr %6, %3  : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }
  llvm.func @neg_extra_use_or_lshr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %4 : i32
  }
  llvm.func @neg_or_extra_use_lshr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %4 : i32
  }
}
