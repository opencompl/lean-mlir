module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i8(i8)
  llvm.func @use.v2i4(vector<2xi4>)
  llvm.func @use.i1(i1)
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.mlir.constant(-16 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %arg0, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @t1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.mlir.constant(-32 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %arg0, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @t2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-16 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.add %arg0, %0  : i8
    %6 = llvm.and %5, %2  : i8
    %7 = llvm.select %4, %arg0, %6 : i1, i8
    llvm.return %7 : i8
  }
  llvm.func @t3_commutative(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.mlir.constant(-16 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "ne" %4, %1 : i8
    llvm.call @use.i1(%5) : (i1) -> ()
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %7, %arg0 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @t4_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.constant(dense<-16> : vector<2xi8>) : vector<2xi8>
    %5 = llvm.and %arg0, %0  : vector<2xi8>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi8>
    %7 = llvm.add %arg0, %3  : vector<2xi8>
    %8 = llvm.and %7, %4  : vector<2xi8>
    %9 = llvm.select %6, %arg0, %8 : vector<2xi1>, vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }
  llvm.func @t5_splat_poison_0b0001(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.poison : i8
    %5 = llvm.mlir.constant(-16 : i8) : i8
    %6 = llvm.mlir.undef : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.and %arg0, %0  : vector<2xi8>
    %12 = llvm.icmp "eq" %11, %2 : vector<2xi8>
    %13 = llvm.add %arg0, %3  : vector<2xi8>
    %14 = llvm.and %13, %10  : vector<2xi8>
    %15 = llvm.select %12, %arg0, %14 : vector<2xi1>, vector<2xi8>
    llvm.return %15 : vector<2xi8>
  }
  llvm.func @t5_splat_poison_0b0010(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.constant(16 : i8) : i8
    %5 = llvm.mlir.undef : vector<2xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.mlir.constant(dense<-16> : vector<2xi8>) : vector<2xi8>
    %11 = llvm.and %arg0, %0  : vector<2xi8>
    %12 = llvm.icmp "eq" %11, %2 : vector<2xi8>
    %13 = llvm.add %arg0, %9  : vector<2xi8>
    %14 = llvm.and %13, %10  : vector<2xi8>
    %15 = llvm.select %12, %arg0, %14 : vector<2xi1>, vector<2xi8>
    llvm.return %15 : vector<2xi8>
  }
  llvm.func @t5_splat_poison_0b0100(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.mlir.constant(dense<-16> : vector<2xi8>) : vector<2xi8>
    %10 = llvm.and %arg0, %0  : vector<2xi8>
    %11 = llvm.icmp "eq" %10, %7 : vector<2xi8>
    %12 = llvm.add %arg0, %8  : vector<2xi8>
    %13 = llvm.and %12, %9  : vector<2xi8>
    %14 = llvm.select %11, %arg0, %13 : vector<2xi1>, vector<2xi8>
    llvm.return %14 : vector<2xi8>
  }
  llvm.func @t5_splat_poison_0b1000(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %10 = llvm.mlir.constant(dense<-16> : vector<2xi8>) : vector<2xi8>
    %11 = llvm.and %arg0, %6  : vector<2xi8>
    %12 = llvm.icmp "eq" %11, %8 : vector<2xi8>
    %13 = llvm.add %arg0, %9  : vector<2xi8>
    %14 = llvm.and %13, %10  : vector<2xi8>
    %15 = llvm.select %12, %arg0, %14 : vector<2xi1>, vector<2xi8>
    llvm.return %15 : vector<2xi8>
  }
  llvm.func @t6_nonsplat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[15, 31]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.constant(dense<[-16, -32]> : vector<2xi8>) : vector<2xi8>
    %5 = llvm.and %arg0, %0  : vector<2xi8>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi8>
    %7 = llvm.add %arg0, %3  : vector<2xi8>
    %8 = llvm.and %7, %4  : vector<2xi8>
    %9 = llvm.select %6, %arg0, %8 : vector<2xi1>, vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }
  llvm.func @t7_nonsplat_bias(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<[15, 16]> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.constant(dense<-16> : vector<2xi8>) : vector<2xi8>
    %5 = llvm.and %arg0, %0  : vector<2xi8>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi8>
    %7 = llvm.add %arg0, %3  : vector<2xi8>
    %8 = llvm.and %7, %4  : vector<2xi8>
    %9 = llvm.select %6, %arg0, %8 : vector<2xi1>, vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }
  llvm.func @t8_nonsplat_masked_by_poison_0b0001(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[15, 31]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.poison : i8
    %5 = llvm.mlir.constant(-16 : i8) : i8
    %6 = llvm.mlir.undef : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.and %arg0, %0  : vector<2xi8>
    %12 = llvm.icmp "eq" %11, %2 : vector<2xi8>
    %13 = llvm.add %arg0, %3  : vector<2xi8>
    %14 = llvm.and %13, %10  : vector<2xi8>
    %15 = llvm.select %12, %arg0, %14 : vector<2xi1>, vector<2xi8>
    llvm.return %15 : vector<2xi8>
  }
  llvm.func @t8_nonsplat_masked_by_poison_0b0010(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[15, 31]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.constant(16 : i8) : i8
    %5 = llvm.mlir.undef : vector<2xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.mlir.constant(dense<[-16, -32]> : vector<2xi8>) : vector<2xi8>
    %11 = llvm.and %arg0, %0  : vector<2xi8>
    %12 = llvm.icmp "eq" %11, %2 : vector<2xi8>
    %13 = llvm.add %arg0, %9  : vector<2xi8>
    %14 = llvm.and %13, %10  : vector<2xi8>
    %15 = llvm.select %12, %arg0, %14 : vector<2xi1>, vector<2xi8>
    llvm.return %15 : vector<2xi8>
  }
  llvm.func @t8_nonsplat_masked_by_poison_0b0100(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[15, 31]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.mlir.constant(dense<[-16, -32]> : vector<2xi8>) : vector<2xi8>
    %10 = llvm.and %arg0, %0  : vector<2xi8>
    %11 = llvm.icmp "eq" %10, %7 : vector<2xi8>
    %12 = llvm.add %arg0, %8  : vector<2xi8>
    %13 = llvm.and %12, %9  : vector<2xi8>
    %14 = llvm.select %11, %arg0, %13 : vector<2xi1>, vector<2xi8>
    llvm.return %14 : vector<2xi8>
  }
  llvm.func @t8_nonsplat_masked_by_poison_0b1000(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %10 = llvm.mlir.constant(dense<[-16, -32]> : vector<2xi8>) : vector<2xi8>
    %11 = llvm.and %arg0, %6  : vector<2xi8>
    %12 = llvm.icmp "eq" %11, %8 : vector<2xi8>
    %13 = llvm.add %arg0, %9  : vector<2xi8>
    %14 = llvm.and %13, %10  : vector<2xi8>
    %15 = llvm.select %12, %arg0, %14 : vector<2xi1>, vector<2xi8>
    llvm.return %15 : vector<2xi8>
  }
  llvm.func @n9_wrong_x0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.mlir.constant(-16 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %arg1, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @n9_wrong_x1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.mlir.constant(-16 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.add %arg1, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %arg0, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @n9_wrong_x2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.mlir.constant(-16 : i8) : i8
    %4 = llvm.and %arg1, %0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %arg0, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @n10_wrong_low_bit_mask(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.mlir.constant(-16 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %arg0, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @n11_wrong_high_bit_mask(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.mlir.constant(-32 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %arg0, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @n12_wrong_bias(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.mlir.constant(-16 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %arg0, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @n13_wrong_constants_alignment_is_not_power_of_two(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.constant(-3 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %arg0, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @n14_wrong_comparison_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.mlir.constant(-16 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %arg0, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @n15_wrong_comparison_predicate_and_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.mlir.constant(-16 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "ult" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.select %5, %arg0, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @n16_oneuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(16 : i8) : i8
    %3 = llvm.mlir.constant(-16 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.and %6, %3  : i8
    llvm.call @use.i8(%7) : (i8) -> ()
    %8 = llvm.select %5, %arg0, %7 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @t17_oneuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-16 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.add %arg0, %0  : i8
    %6 = llvm.and %5, %2  : i8
    llvm.call @use.i8(%6) : (i8) -> ()
    %7 = llvm.select %4, %arg0, %6 : i1, i8
    llvm.return %7 : i8
  }
  llvm.func @t18_replacement_0b0001(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(dense<3> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(0 : i4) : i4
    %3 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.mlir.poison : i4
    %5 = llvm.mlir.constant(-4 : i4) : i4
    %6 = llvm.mlir.undef : vector<2xi4>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<2xi4>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<2xi4>
    %11 = llvm.and %arg0, %1  : vector<2xi4>
    %12 = llvm.icmp "eq" %11, %3 : vector<2xi4>
    %13 = llvm.add %arg0, %1  : vector<2xi4>
    %14 = llvm.and %13, %10  : vector<2xi4>
    llvm.call @use.v2i4(%14) : (vector<2xi4>) -> ()
    %15 = llvm.select %12, %arg0, %14 : vector<2xi1>, vector<2xi4>
    llvm.return %15 : vector<2xi4>
  }
  llvm.func @t18_replacement_0b0010(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(dense<3> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(0 : i4) : i4
    %3 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.mlir.poison : i4
    %5 = llvm.mlir.undef : vector<2xi4>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : vector<2xi4>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %4, %7[%8 : i32] : vector<2xi4>
    %10 = llvm.mlir.constant(-4 : i4) : i4
    %11 = llvm.mlir.constant(dense<-4> : vector<2xi4>) : vector<2xi4>
    %12 = llvm.and %arg0, %1  : vector<2xi4>
    %13 = llvm.icmp "eq" %12, %3 : vector<2xi4>
    %14 = llvm.add %arg0, %9  : vector<2xi4>
    %15 = llvm.and %14, %11  : vector<2xi4>
    llvm.call @use.v2i4(%15) : (vector<2xi4>) -> ()
    %16 = llvm.select %13, %arg0, %15 : vector<2xi1>, vector<2xi4>
    llvm.return %16 : vector<2xi4>
  }
  llvm.func @t18_replacement_0b0100(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(dense<3> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.poison : i4
    %3 = llvm.mlir.constant(0 : i4) : i4
    %4 = llvm.mlir.undef : vector<2xi4>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi4>
    %9 = llvm.mlir.constant(-4 : i4) : i4
    %10 = llvm.mlir.constant(dense<-4> : vector<2xi4>) : vector<2xi4>
    %11 = llvm.and %arg0, %1  : vector<2xi4>
    %12 = llvm.icmp "eq" %11, %8 : vector<2xi4>
    %13 = llvm.add %arg0, %1  : vector<2xi4>
    %14 = llvm.and %13, %10  : vector<2xi4>
    llvm.call @use.v2i4(%14) : (vector<2xi4>) -> ()
    %15 = llvm.select %12, %arg0, %14 : vector<2xi1>, vector<2xi4>
    llvm.return %15 : vector<2xi4>
  }
  llvm.func @t18_replacement_0b1000(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.poison : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(0 : i4) : i4
    %8 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %9 = llvm.mlir.constant(dense<3> : vector<2xi4>) : vector<2xi4>
    %10 = llvm.mlir.constant(-4 : i4) : i4
    %11 = llvm.mlir.constant(dense<-4> : vector<2xi4>) : vector<2xi4>
    %12 = llvm.and %arg0, %6  : vector<2xi4>
    %13 = llvm.icmp "eq" %12, %8 : vector<2xi4>
    %14 = llvm.add %arg0, %9  : vector<2xi4>
    %15 = llvm.and %14, %11  : vector<2xi4>
    llvm.call @use.v2i4(%15) : (vector<2xi4>) -> ()
    %16 = llvm.select %13, %arg0, %15 : vector<2xi1>, vector<2xi4>
    llvm.return %16 : vector<2xi4>
  }
}
