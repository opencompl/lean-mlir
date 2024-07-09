module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @icmp_power2_and_icmp_shifted_mask_2147483648_1610612736(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(1610612736 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(1610612736 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_2147483648_2147483647(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_2147483648_805306368(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(805306368 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(805306368 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_1073741824_1073741823(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(1073741823 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(1073741823 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_8_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_8_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_8_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_8_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_8_5_gap_in_mask_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_8_5_gap_in_mask_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_8_3_gap_between_masks_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_8_3_gap_between_masks_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_256_239_gap_in_mask_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(256 : i32) : i32
    %1 = llvm.mlir.constant(239 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_256_239_gap_in_mask_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(256 : i32) : i32
    %1 = llvm.mlir.constant(239 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_8_112_mask_to_left_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(112 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_8_112_mask_to_left_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(112 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_8_56_mask_overlap_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(56 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_8_56_mask_overlap_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(56 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_8_24_mask_overlap_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_8_24_mask_overlap_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_8_12_mask_overlap_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_swapped_8_12_mask_overlap_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147483647(%arg0: vector<1xi32>) -> vector<1xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<1xi32>) : vector<1xi32>
    %1 = llvm.mlir.constant(dense<2147483647> : vector<1xi32>) : vector<1xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<1xi32>
    %3 = llvm.and %arg0, %1  : vector<1xi32>
    %4 = llvm.icmp "ne" %3, %1 : vector<1xi32>
    %5 = llvm.and %2, %4  : vector<1xi1>
    llvm.return %5 : vector<1xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147483647(%arg0: vector<1xi32>) -> vector<1xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<1xi32>) : vector<1xi32>
    %1 = llvm.mlir.constant(dense<2147483647> : vector<1xi32>) : vector<1xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<1xi32>
    %3 = llvm.and %arg0, %1  : vector<1xi32>
    %4 = llvm.icmp "ne" %3, %1 : vector<1xi32>
    %5 = llvm.and %4, %2  : vector<1xi1>
    llvm.return %5 : vector<1xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_2147483648_1610612736_2147483647(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1610612736, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.and %arg0, %1  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %1 : vector<2xi32>
    %5 = llvm.and %2, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1610612736_2147483647(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1610612736, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.and %arg0, %1  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %1 : vector<2xi32>
    %5 = llvm.and %4, %2  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_splat_poison_2147483648_1610612736_2147483647(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<[1610612736, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.icmp "ult" %arg0, %6 : vector<2xi32>
    %9 = llvm.and %arg0, %7  : vector<2xi32>
    %10 = llvm.icmp "ne" %9, %7 : vector<2xi32>
    %11 = llvm.and %8, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_swapped_splat_poison_2147483648_1610612736_2147483647(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<[1610612736, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.icmp "ult" %arg0, %6 : vector<2xi32>
    %9 = llvm.and %arg0, %7  : vector<2xi32>
    %10 = llvm.icmp "ne" %9, %7 : vector<2xi32>
    %11 = llvm.and %10, %8  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_splat_undef_2147483648_1610612736_2147483647(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<[1610612736, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.icmp "ult" %arg0, %6 : vector<2xi32>
    %9 = llvm.and %arg0, %7  : vector<2xi32>
    %10 = llvm.icmp "ne" %9, %7 : vector<2xi32>
    %11 = llvm.and %8, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_swapped_splat_undef_2147483648_1610612736_2147483647(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<[1610612736, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.icmp "ult" %arg0, %6 : vector<2xi32>
    %9 = llvm.and %arg0, %7  : vector<2xi32>
    %10 = llvm.icmp "ne" %9, %7 : vector<2xi32>
    %11 = llvm.and %10, %8  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_128_others(%arg0: vector<7xi8>) -> vector<7xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<7xi8>) : vector<7xi8>
    %1 = llvm.mlir.constant(dense<[127, 126, 124, 120, 112, 96, 64]> : vector<7xi8>) : vector<7xi8>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<7xi8>
    %3 = llvm.and %arg0, %1  : vector<7xi8>
    %4 = llvm.icmp "ne" %3, %1 : vector<7xi8>
    %5 = llvm.and %2, %4  : vector<7xi1>
    llvm.return %5 : vector<7xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_swapped_128_others(%arg0: vector<7xi8>) -> vector<7xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<7xi8>) : vector<7xi8>
    %1 = llvm.mlir.constant(dense<[127, 126, 124, 120, 112, 96, 64]> : vector<7xi8>) : vector<7xi8>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<7xi8>
    %3 = llvm.and %arg0, %1  : vector<7xi8>
    %4 = llvm.icmp "ne" %3, %1 : vector<7xi8>
    %5 = llvm.and %4, %2  : vector<7xi1>
    llvm.return %5 : vector<7xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_64_others(%arg0: vector<6xi8>) -> vector<6xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<6xi8>) : vector<6xi8>
    %1 = llvm.mlir.constant(dense<[63, 62, 60, 56, 48, 32]> : vector<6xi8>) : vector<6xi8>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<6xi8>
    %3 = llvm.and %arg0, %1  : vector<6xi8>
    %4 = llvm.icmp "ne" %3, %1 : vector<6xi8>
    %5 = llvm.and %2, %4  : vector<6xi1>
    llvm.return %5 : vector<6xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_swapped_64_others(%arg0: vector<6xi8>) -> vector<6xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<6xi8>) : vector<6xi8>
    %1 = llvm.mlir.constant(dense<[63, 62, 60, 56, 48, 32]> : vector<6xi8>) : vector<6xi8>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<6xi8>
    %3 = llvm.and %arg0, %1  : vector<6xi8>
    %4 = llvm.icmp "ne" %3, %1 : vector<6xi8>
    %5 = llvm.and %2, %4  : vector<6xi1>
    llvm.return %5 : vector<6xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147482647_gap_in_mask_fail(%arg0: vector<1xi32>) -> vector<1xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<1xi32>) : vector<1xi32>
    %1 = llvm.mlir.constant(dense<2147482647> : vector<1xi32>) : vector<1xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<1xi32>
    %3 = llvm.and %arg0, %1  : vector<1xi32>
    %4 = llvm.icmp "ne" %3, %1 : vector<1xi32>
    %5 = llvm.and %2, %4  : vector<1xi1>
    llvm.return %5 : vector<1xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147482647_gap_in_mask_fail(%arg0: vector<1xi32>) -> vector<1xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<1xi32>) : vector<1xi32>
    %1 = llvm.mlir.constant(dense<2147482647> : vector<1xi32>) : vector<1xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<1xi32>
    %3 = llvm.and %arg0, %1  : vector<1xi32>
    %4 = llvm.icmp "ne" %3, %1 : vector<1xi32>
    %5 = llvm.and %4, %2  : vector<1xi1>
    llvm.return %5 : vector<1xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_2147483648_1073741823_gap_between_masks_fail(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1610612736, 1073741823]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.and %arg0, %1  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %1 : vector<2xi32>
    %5 = llvm.and %2, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1073741823_gap_between_masks_fail(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1610612736, 1073741823]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.and %arg0, %1  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %1 : vector<2xi32>
    %5 = llvm.and %4, %2  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_128_1_of_7_fail(%arg0: vector<7xi8>) -> vector<7xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<7xi8>) : vector<7xi8>
    %1 = llvm.mlir.constant(dense<[125, 122, 116, 104, 80, 32, 64]> : vector<7xi8>) : vector<7xi8>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<7xi8>
    %3 = llvm.and %arg0, %1  : vector<7xi8>
    %4 = llvm.icmp "ne" %3, %1 : vector<7xi8>
    %5 = llvm.and %2, %4  : vector<7xi1>
    llvm.return %5 : vector<7xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_swapped_128_1_of_7_fail(%arg0: vector<7xi8>) -> vector<7xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<7xi8>) : vector<7xi8>
    %1 = llvm.mlir.constant(dense<[125, 122, 116, 104, 80, 32, 64]> : vector<7xi8>) : vector<7xi8>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<7xi8>
    %3 = llvm.and %arg0, %1  : vector<7xi8>
    %4 = llvm.icmp "ne" %3, %1 : vector<7xi8>
    %5 = llvm.and %4, %2  : vector<7xi1>
    llvm.return %5 : vector<7xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_128_0_of_6_fail(%arg0: vector<6xi8>) -> vector<6xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<6xi8>) : vector<6xi8>
    %1 = llvm.mlir.constant(dense<[125, 122, 116, 104, 80, 32]> : vector<6xi8>) : vector<6xi8>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<6xi8>
    %3 = llvm.and %arg0, %1  : vector<6xi8>
    %4 = llvm.icmp "ne" %3, %1 : vector<6xi8>
    %5 = llvm.and %2, %4  : vector<6xi1>
    llvm.return %5 : vector<6xi1>
  }
  llvm.func @icmp_power2_and_icmp_shifted_mask_vector_swapped_128_0_of_6_fail(%arg0: vector<6xi8>) -> vector<6xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<6xi8>) : vector<6xi8>
    %1 = llvm.mlir.constant(dense<[125, 122, 116, 104, 80, 32]> : vector<6xi8>) : vector<6xi8>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<6xi8>
    %3 = llvm.and %arg0, %1  : vector<6xi8>
    %4 = llvm.icmp "ne" %3, %1 : vector<6xi8>
    %5 = llvm.and %4, %2  : vector<6xi1>
    llvm.return %5 : vector<6xi1>
  }
}
