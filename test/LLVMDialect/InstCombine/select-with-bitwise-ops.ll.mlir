module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @use_vec(vector<2xi8>)
  llvm.func @select_icmp_eq_and_1_0_or_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_and_1_0_or_2_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @select_icmp_eq_and_1_0_or_2_vec_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %9 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %10 = llvm.and %arg0, %6  : vector<2xi32>
    %11 = llvm.icmp "eq" %10, %8 : vector<2xi32>
    %12 = llvm.or %arg1, %9  : vector<2xi32>
    %13 = llvm.select %11, %arg1, %12 : vector<2xi1>, vector<2xi32>
    llvm.return %13 : vector<2xi32>
  }
  llvm.func @select_icmp_eq_and_1_0_or_2_vec_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %9 = llvm.and %arg0, %0  : vector<2xi32>
    %10 = llvm.icmp "eq" %9, %7 : vector<2xi32>
    %11 = llvm.or %arg1, %8  : vector<2xi32>
    %12 = llvm.select %10, %arg1, %11 : vector<2xi1>, vector<2xi32>
    llvm.return %12 : vector<2xi32>
  }
  llvm.func @select_icmp_eq_and_1_0_or_2_vec_poison3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.undef : vector<2xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<2xi32>
    %10 = llvm.and %arg0, %0  : vector<2xi32>
    %11 = llvm.icmp "eq" %10, %2 : vector<2xi32>
    %12 = llvm.or %arg1, %9  : vector<2xi32>
    %13 = llvm.select %11, %arg1, %12 : vector<2xi1>, vector<2xi32>
    llvm.return %13 : vector<2xi32>
  }
  llvm.func @select_icmp_eq_and_1_0_xor_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_and_1_0_and_not_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_and_32_0_or_8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_and_32_0_or_8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @select_icmp_eq_and_32_0_xor_8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_and_32_0_and_not_8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-9 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_ne_0_and_4096_or_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_icmp_ne_0_and_4096_or_4096_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4096> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %2, %3 : vector<2xi32>
    %5 = llvm.or %arg1, %0  : vector<2xi32>
    %6 = llvm.select %4, %arg1, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @select_icmp_ne_0_and_4096_xor_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_icmp_ne_0_and_4096_and_not_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_and_4096_0_or_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_icmp_eq_and_4096_0_or_4096_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4096> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    %5 = llvm.or %arg1, %0  : vector<2xi32>
    %6 = llvm.select %4, %arg1, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @select_icmp_eq_and_4096_0_xor_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_icmp_eq_and_4096_0_and_not_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_0_and_1_or_1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_0_and_1_or_1_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi64>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi64>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @select_icmp_eq_0_and_1_xor_1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_0_and_1_and_not_1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_ne_0_and_4096_or_32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_ne_0_and_4096_xor_32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_ne_0_and_4096_and_not_32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-33 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_ne_0_and_32_or_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4096 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_ne_0_and_32_or_4096_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<4096> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "ne" %2, %4 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @select_icmp_ne_0_and_32_xor_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4096 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_ne_0_and_32_and_not_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_ne_0_and_1073741824_or_8(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i8) : i8
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i8
    %6 = llvm.select %4, %arg1, %5 : i1, i8
    llvm.return %6 : i8
  }
  llvm.func @select_icmp_ne_0_and_1073741824_xor_8(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i8) : i8
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i8
    %6 = llvm.select %4, %arg1, %5 : i1, i8
    llvm.return %6 : i8
  }
  llvm.func @select_icmp_ne_0_and_1073741824_and_not_8(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-9 : i8) : i8
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.select %4, %arg1, %5 : i1, i8
    llvm.return %6 : i8
  }
  llvm.func @select_icmp_ne_0_and_8_or_1073741824(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(1073741824 : i32) : i32
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "ne" %1, %3 : i8
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_ne_0_and_8_xor_1073741824(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(1073741824 : i32) : i32
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "ne" %1, %3 : i8
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_ne_0_and_8_and_not_1073741824(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-1073741825 : i32) : i32
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "ne" %1, %3 : i8
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_and_1_0_or_vector_of_2s(%arg0: i32, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : vector<2xi32>
    %6 = llvm.select %4, %arg1, %5 : i1, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @select_icmp_and_8_ne_0_xor_8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_icmp_and_8_eq_0_xor_8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_icmp_x_and_8_eq_0_y_xor_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i64
    %6 = llvm.select %4, %arg1, %5 : i1, i64
    llvm.return %6 : i64
  }
  llvm.func @select_icmp_x_and_8_ne_0_y_xor_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }
  llvm.func @select_icmp_x_and_8_ne_0_y_or_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }
  llvm.func @select_icmp_x_and_8_ne_0_y_or_8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<8> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi64>
    %7 = llvm.select %5, %6, %arg1 : vector<2xi1>, vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }
  llvm.func @select_icmp_x_and_8_ne_0_y_and_not_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-9 : i64) : i64
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }
  llvm.func @select_icmp_and_2147483648_ne_0_xor_2147483648(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_icmp_and_2147483648_eq_0_xor_2147483648(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @select_icmp_x_and_2147483648_ne_0_or_2147483648(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @test68(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test68vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @test68_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test68_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test69(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test69vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @test69_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test69_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test70(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.select %2, %3, %arg1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @test70_multiuse(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.or %arg1, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %2, %3, %arg1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @shift_no_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @shift_no_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @shift_no_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @no_shift_no_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.mul %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @no_shift_no_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.mul %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @no_shift_no_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.add %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @no_shift_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.mul %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @no_shift_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.mul %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @no_shift_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @shift_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @shift_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @shift_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2049 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }
  llvm.func @shift_no_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @shift_no_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @shift_no_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @no_shift_no_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @no_shift_no_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @no_shift_no_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @no_shift_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @no_shift_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @no_shift_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @shift_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @shift_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @shift_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2049 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @shift_no_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @shift_no_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @shift_no_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @no_shift_no_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @no_shift_no_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @no_shift_no_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @no_shift_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @no_shift_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }
  llvm.func @no_shift_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @shift_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @shift_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @shift_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }
  llvm.func @set_bits(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.select %arg1, %3, %2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @set_bits_not_inverse_constant(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.select %arg1, %3, %2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @set_bits_extra_use1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.select %arg1, %3, %2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @set_bits_extra_use2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %3, %2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @clear_bits(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<37> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-38> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.or %arg0, %1  : vector<2xi8>
    %4 = llvm.select %arg1, %2, %3 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @clear_bits_not_inverse_constant(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(37 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<-38> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.and %arg0, %6  : vector<2xi8>
    %9 = llvm.or %arg0, %7  : vector<2xi8>
    %10 = llvm.select %arg1, %8, %9 : vector<2xi1>, vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }
  llvm.func @clear_bits_extra_use1(%arg0: vector<2xi8>, %arg1: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<37> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-38> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    llvm.call @use_vec(%2) : (vector<2xi8>) -> ()
    %3 = llvm.or %arg0, %1  : vector<2xi8>
    %4 = llvm.select %arg1, %2, %3 : i1, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @clear_bits_extra_use2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @xor_i8_to_i64_shl_save_and_eq(%arg0: i8, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.xor %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }
  llvm.func @xor_i8_to_i64_shl_save_and_ne(%arg0: i8, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    %5 = llvm.xor %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }
  llvm.func @select_icmp_eq_and_1_0_srem_2_fail_null_identity(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.srem %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_and_1_0_sdiv_2_fail_null_1_identity(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.sdiv %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @select_icmp_eq_and_1_0_lshr_fv(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.lshr %arg1, %2  : i8
    %6 = llvm.select %4, %arg1, %5 : i1, i8
    llvm.return %6 : i8
  }
  llvm.func @select_icmp_eq_and_1_0_lshr_tv(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    %5 = llvm.lshr %arg1, %2  : i8
    %6 = llvm.select %4, %5, %arg1 : i1, i8
    llvm.return %6 : i8
  }
}
