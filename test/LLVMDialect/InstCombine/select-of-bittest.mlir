module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @and_lshr_and(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.and %4, %0  : i32
    %6 = llvm.select %3, %5, %0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @and_lshr_and_splatvec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    %5 = llvm.lshr %arg0, %0  : vector<2xi32>
    %6 = llvm.and %5, %0  : vector<2xi32>
    %7 = llvm.select %4, %6, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @and_lshr_and_vec_v0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1, 4]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.lshr %arg0, %3  : vector<2xi32>
    %7 = llvm.and %6, %3  : vector<2xi32>
    %8 = llvm.select %5, %7, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @and_lshr_and_vec_v1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.lshr %arg0, %3  : vector<2xi32>
    %7 = llvm.and %6, %0  : vector<2xi32>
    %8 = llvm.select %5, %7, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @and_lshr_and_vec_v2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi32>
    %7 = llvm.lshr %arg0, %3  : vector<2xi32>
    %8 = llvm.and %7, %4  : vector<2xi32>
    %9 = llvm.select %6, %8, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }
  llvm.func @and_lshr_and_vec_poison(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %8  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %16 : vector<3xi32>
    %19 = llvm.lshr %arg0, %8  : vector<3xi32>
    %20 = llvm.and %19, %8  : vector<3xi32>
    %21 = llvm.select %18, %20, %8 : vector<3xi1>, vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }
  llvm.func @and_and(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.select %4, %5, %2 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @and_and_splatvec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.and %arg0, %3  : vector<2xi32>
    %7 = llvm.select %5, %6, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @and_and_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[6, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.and %arg0, %3  : vector<2xi32>
    %7 = llvm.select %5, %6, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @and_and_vec_poison(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.mlir.undef : vector<3xi32>
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.insertelement %17, %18[%19 : i32] : vector<3xi32>
    %21 = llvm.mlir.constant(1 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<3xi32>
    %23 = llvm.mlir.constant(2 : i32) : i32
    %24 = llvm.insertelement %17, %22[%23 : i32] : vector<3xi32>
    %25 = llvm.and %arg0, %8  : vector<3xi32>
    %26 = llvm.icmp "eq" %25, %16 : vector<3xi32>
    %27 = llvm.and %arg0, %24  : vector<3xi32>
    %28 = llvm.select %26, %27, %24 : vector<3xi1>, vector<3xi32>
    llvm.return %28 : vector<3xi32>
  }
  llvm.func @f_var0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @f_var0_commutative_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @f_var0_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    %5 = llvm.lshr %arg0, %2  : vector<2xi32>
    %6 = llvm.and %5, %2  : vector<2xi32>
    %7 = llvm.select %4, %6, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @f_var0_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %arg1  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %1 : vector<2xi32>
    %6 = llvm.lshr %arg0, %2  : vector<2xi32>
    %7 = llvm.and %6, %3  : vector<2xi32>
    %8 = llvm.select %5, %7, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @f_var0_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %arg1  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %8 : vector<3xi32>
    %19 = llvm.lshr %arg0, %16  : vector<3xi32>
    %20 = llvm.and %19, %16  : vector<3xi32>
    %21 = llvm.select %18, %20, %16 : vector<3xi1>, vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }
  llvm.func @f_var1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.select %3, %4, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @f_var1_commutative_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.select %3, %4, %1 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @f_var1_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    %5 = llvm.and %arg0, %2  : vector<2xi32>
    %6 = llvm.select %4, %5, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @f_var1_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %arg1  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %8 : vector<3xi32>
    %19 = llvm.and %arg0, %16  : vector<3xi32>
    %20 = llvm.select %18, %19, %16 : vector<3xi1>, vector<3xi32>
    llvm.return %20 : vector<3xi32>
  }
  llvm.func @f_var2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.lshr %arg0, %arg1  : i32
    %5 = llvm.and %4, %0  : i32
    %6 = llvm.select %3, %5, %0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @f_var2_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    %5 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %6 = llvm.and %5, %0  : vector<2xi32>
    %7 = llvm.select %4, %6, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @f_var2_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %7 = llvm.and %6, %3  : vector<2xi32>
    %8 = llvm.select %5, %7, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @f_var2_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %8  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %16 : vector<3xi32>
    %19 = llvm.lshr %arg0, %arg1  : vector<3xi32>
    %20 = llvm.and %19, %8  : vector<3xi32>
    %21 = llvm.select %18, %20, %8 : vector<3xi1>, vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }
  llvm.func @f_var3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %arg2  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @f_var3_commutative_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %arg2  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @f_var3_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    %5 = llvm.lshr %arg0, %arg2  : vector<2xi32>
    %6 = llvm.and %5, %2  : vector<2xi32>
    %7 = llvm.select %4, %6, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @f_var3_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %arg1  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %8 : vector<3xi32>
    %19 = llvm.lshr %arg0, %arg2  : vector<3xi32>
    %20 = llvm.and %19, %16  : vector<3xi32>
    %21 = llvm.select %18, %20, %16 : vector<3xi1>, vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }
  llvm.func @use32(i32)
  llvm.func @use1(i1)
  llvm.func @n_var0_oneuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %arg2  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use1(%3) : (i1) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.return %6 : i32
  }
  llvm.func @n_var1_oneuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.select %3, %4, %1 : i1, i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use1(%3) : (i1) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }
  llvm.func @n0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.lshr %arg1, %0  : i32
    %5 = llvm.and %4, %0  : i32
    %6 = llvm.select %3, %5, %0 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @n1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %2 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @n2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.lshr %arg0, %2  : i32
    %6 = llvm.and %5, %0  : i32
    %7 = llvm.select %4, %6, %1 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.select %4, %5, %1 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @n4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.lshr %arg0, %2  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.select %4, %6, %0 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.select %4, %5, %2 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @n6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.lshr %arg0, %2  : i32
    %6 = llvm.and %5, %0  : i32
    %7 = llvm.select %4, %6, %0 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @n7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.select %4, %5, %2 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @n8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %0  : i32
    %6 = llvm.select %3, %5, %0 : i1, i32
    llvm.return %6 : i32
  }
}
