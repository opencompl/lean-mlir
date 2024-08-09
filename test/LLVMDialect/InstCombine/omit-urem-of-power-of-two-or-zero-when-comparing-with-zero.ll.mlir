module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @p0_scalar_urem_by_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.urem %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }
  llvm.func @p1_scalar_urem_by_nonconst(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.urem %3, %4  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @p2_scalar_shifted_urem_by_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %arg1  : i32
    %5 = llvm.urem %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @p3_scalar_shifted2_urem_by_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %arg1  : i32
    %5 = llvm.urem %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @p4_vector_urem_by_const__splat(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.and %arg0, %0  : vector<4xi32>
    %5 = llvm.urem %4, %1  : vector<4xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<4xi32>
    llvm.return %6 : vector<4xi1>
  }
  llvm.func @p5_vector_urem_by_const__nonsplat(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[128, 2, 4, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[3, 5, 6, 9]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.and %arg0, %0  : vector<4xi32>
    %5 = llvm.urem %4, %1  : vector<4xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<4xi32>
    llvm.return %6 : vector<4xi1>
  }
  llvm.func @p6_vector_urem_by_const__nonsplat_poison0(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %14 = llvm.and %arg0, %10  : vector<4xi32>
    %15 = llvm.urem %14, %11  : vector<4xi32>
    %16 = llvm.icmp "eq" %15, %13 : vector<4xi32>
    llvm.return %16 : vector<4xi1>
  }
  llvm.func @p7_vector_urem_by_const__nonsplat_poison2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %2, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %3, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %2, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.and %arg0, %0  : vector<4xi32>
    %14 = llvm.urem %13, %1  : vector<4xi32>
    %15 = llvm.icmp "eq" %14, %12 : vector<4xi32>
    llvm.return %15 : vector<4xi1>
  }
  llvm.func @p8_vector_urem_by_const__nonsplat_poison3(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.undef : vector<4xi32>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %12, %13[%14 : i32] : vector<4xi32>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %12, %15[%16 : i32] : vector<4xi32>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.insertelement %1, %17[%18 : i32] : vector<4xi32>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.insertelement %12, %19[%20 : i32] : vector<4xi32>
    %22 = llvm.and %arg0, %10  : vector<4xi32>
    %23 = llvm.urem %22, %11  : vector<4xi32>
    %24 = llvm.icmp "eq" %23, %21 : vector<4xi32>
    llvm.return %24 : vector<4xi1>
  }
  llvm.func @n0_urem_of_maybe_not_power_of_two(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.urem %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @n1_urem_by_maybe_power_of_two(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.urem %3, %4  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
}
