module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @masked_and_notallzeroes(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_and_notallzeroes_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<39> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    %6 = llvm.and %arg0, %3  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %2 : vector<2xi32>
    %8 = llvm.and %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @masked_and_notallzeroes_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_or_allzeroes(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_or_allzeroes_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_and_notallones(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @masked_and_notallones_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.select %4, %6, %2 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @masked_or_allones(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @masked_or_allones_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.select %4, %2, %6 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @masked_and_notA(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(78 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %arg0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "ne" %4, %arg0 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @masked_and_notA_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(78 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %arg0 : i32
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "ne" %5, %arg0 : i32
    %7 = llvm.select %4, %6, %2 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @masked_and_notA_slightly_optimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.icmp "uge" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %arg0 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @masked_and_notA_slightly_optimized_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "uge" %arg0, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "ne" %4, %arg0 : i32
    %6 = llvm.select %3, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @masked_or_A(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(78 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %arg0 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @masked_or_A_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(78 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %arg0 : i32
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "eq" %5, %arg0 : i32
    %7 = llvm.select %4, %2, %6 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @masked_or_A_slightly_optimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "eq" %3, %arg0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @masked_or_A_slightly_optimized_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %arg0 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @masked_or_allzeroes_notoptimised(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_or_allzeroes_notoptimised_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(39 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @nomask_lhs(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @nomask_lhs_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @nomask_rhs(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @nomask_rhs_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @fold_mask_cmps_to_false(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @fold_mask_cmps_to_false_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @fold_mask_cmps_to_true(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.icmp "ne" %arg0, %0 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @fold_mask_cmps_to_true_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.icmp "ne" %arg0, %0 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @nomask_splat_and_B_allones(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<1879048192> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.icmp "slt" %arg0, %6 : vector<2xi32>
    %9 = llvm.and %arg0, %7  : vector<2xi32>
    %10 = llvm.icmp "eq" %9, %7 : vector<2xi32>
    %11 = llvm.and %8, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @nomask_splat_and_B_mixed(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<1879048192> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.icmp "sgt" %arg0, %6 : vector<2xi32>
    %9 = llvm.and %arg0, %7  : vector<2xi32>
    %10 = llvm.icmp "eq" %9, %7 : vector<2xi32>
    %11 = llvm.and %8, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @cmpeq_bitwise(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.xor %arg2, %arg3  : i8
    %3 = llvm.or %1, %2  : i8
    %4 = llvm.icmp "eq" %3, %0 : i8
    llvm.return %4 : i1
  }
  llvm.func @cmpne_bitwise(%arg0: vector<2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>, %arg3: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi64>
    %3 = llvm.xor %arg2, %arg3  : vector<2xi64>
    %4 = llvm.or %2, %3  : vector<2xi64>
    %5 = llvm.icmp "ne" %4, %1 : vector<2xi64>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1_vector(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi32>
    %7 = llvm.and %arg0, %3  : vector<2xi32>
    %8 = llvm.icmp "eq" %7, %4 : vector<2xi32>
    %9 = llvm.and %6, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %6, %4, %8 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %7, %5, %3 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %7, %5, %3 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %7, %5, %3 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.select %7, %5, %3 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.select %8, %6, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %7, %3, %5 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %7, %3, %5 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %7, %3, %5 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.select %7, %3, %5 : i1, i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.or %7, %5  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.select %8, %4, %6 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @masked_icmps_bmask_notmixed_or(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(243 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_bmask_notmixed_or_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<-13> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.and %arg0, %0  : vector<2xi8>
    %5 = llvm.icmp "eq" %4, %1 : vector<2xi8>
    %6 = llvm.and %arg0, %2  : vector<2xi8>
    %7 = llvm.icmp "eq" %6, %3 : vector<2xi8>
    %8 = llvm.or %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @masked_icmps_bmask_notmixed_or_vec_poison1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.mlir.constant(dense<-13> : vector<2xi8>) : vector<2xi8>
    %10 = llvm.and %arg0, %0  : vector<2xi8>
    %11 = llvm.icmp "eq" %10, %7 : vector<2xi8>
    %12 = llvm.and %arg0, %8  : vector<2xi8>
    %13 = llvm.icmp "eq" %12, %9 : vector<2xi8>
    %14 = llvm.or %11, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }
  llvm.func @masked_icmps_bmask_notmixed_or_vec_poison2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.constant(-13 : i8) : i8
    %5 = llvm.mlir.undef : vector<2xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.and %arg0, %0  : vector<2xi8>
    %11 = llvm.icmp "eq" %10, %1 : vector<2xi8>
    %12 = llvm.and %arg0, %2  : vector<2xi8>
    %13 = llvm.icmp "eq" %12, %9 : vector<2xi8>
    %14 = llvm.or %11, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }
  llvm.func @masked_icmps_bmask_notmixed_or_contradict_notoptimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(242 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_bmask_notmixed_and(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(243 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_bmask_notmixed_and_contradict_notoptimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(242 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_bmask_notmixed_and_expected_false(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(242 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @masked_icmps_bmask_notmixed_not_subset_notoptimized(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(254 : i32) : i32
    %1 = llvm.mlir.constant(252 : i32) : i32
    %2 = llvm.mlir.constant(253 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }
}
