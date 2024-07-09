module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_v4i32_xor_repeated_and_0(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.and %arg0, %arg1  : vector<4xi32>
    %1 = llvm.and %arg0, %arg2  : vector<4xi32>
    %2 = llvm.xor %0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @test_v4i32_xor_repeated_and_1(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.and %arg0, %arg1  : vector<4xi32>
    %1 = llvm.and %arg2, %arg0  : vector<4xi32>
    %2 = llvm.xor %0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @test_v4i32_xor_bswap_splatconst(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<255> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.intr.bswap(%arg0)  : (vector<4xi32>) -> vector<4xi32>
    %2 = llvm.xor %1, %0  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @test_v4i32_xor_bswap_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, -16777216, 2, 3]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.intr.bswap(%arg0)  : (vector<4xi32>) -> vector<4xi32>
    %2 = llvm.xor %1, %0  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @test_v4i32_xor_bswap_const_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.intr.bswap(%arg0)  : (vector<4xi32>) -> vector<4xi32>
    %14 = llvm.xor %13, %12  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }
  llvm.func @test_v4i32_demorgan_and(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.xor %0, %arg0  : vector<4xi32>
    %2 = llvm.and %1, %arg1  : vector<4xi32>
    %3 = llvm.xor %0, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_demorgan_or(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.xor %0, %arg0  : vector<4xi32>
    %2 = llvm.or %1, %arg1  : vector<4xi32>
    %3 = llvm.xor %0, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_not_ashr_not(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.xor %0, %arg0  : vector<4xi32>
    %2 = llvm.ashr %1, %arg1  : vector<4xi32>
    %3 = llvm.xor %0, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_not_ashr_not_poison(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.undef : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<4xi32>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<4xi32>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %0, %15[%16 : i32] : vector<4xi32>
    %18 = llvm.mlir.constant(3 : i32) : i32
    %19 = llvm.insertelement %1, %17[%18 : i32] : vector<4xi32>
    %20 = llvm.xor %10, %arg0  : vector<4xi32>
    %21 = llvm.ashr %20, %arg1  : vector<4xi32>
    %22 = llvm.xor %19, %21  : vector<4xi32>
    llvm.return %22 : vector<4xi32>
  }
  llvm.func @test_v4i32_not_ashr_negative_splatconst(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.ashr %0, %arg0  : vector<4xi32>
    %3 = llvm.xor %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_not_ashr_negative_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[-3, -5, -7, -9]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.ashr %0, %arg0  : vector<4xi32>
    %3 = llvm.xor %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_not_ashr_negative_const_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-9 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(-5 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.constant(-1 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %13, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.ashr %12, %arg0  : vector<4xi32>
    %24 = llvm.xor %22, %23  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @test_v4i32_not_lshr_nonnegative_splatconst(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.xor %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_not_lshr_nonnegative_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[3, 5, 7, 9]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.xor %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_not_lshr_nonnegative_const_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.constant(-1 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %13, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.lshr %12, %arg0  : vector<4xi32>
    %24 = llvm.xor %22, %23  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @test_v4i32_not_sub_splatconst(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.xor %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_not_sub_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[3, 5, -1, 15]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.xor %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_not_sub_const_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.undef : vector<4xi32>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<4xi32>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %1, %15[%16 : i32] : vector<4xi32>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.insertelement %1, %17[%18 : i32] : vector<4xi32>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.insertelement %2, %19[%20 : i32] : vector<4xi32>
    %22 = llvm.sub %12, %arg0  : vector<4xi32>
    %23 = llvm.xor %21, %22  : vector<4xi32>
    llvm.return %23 : vector<4xi32>
  }
  llvm.func @test_v4i32_xor_signmask_sub_splatconst(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.xor %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_xor_signmask_sub_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[3, 5, -1, 15]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.xor %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_xor_signmask_sub_const_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.constant(-2147483648 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %13, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %2, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.sub %12, %arg0  : vector<4xi32>
    %24 = llvm.xor %22, %23  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
  llvm.func @test_v4i32_xor_signmask_add_splatconst(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %0, %arg0  : vector<4xi32>
    %3 = llvm.xor %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_xor_signmask_add_const(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[3, 5, -1, 15]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %0, %arg0  : vector<4xi32>
    %3 = llvm.xor %1, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_xor_signmask_add_const_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.constant(-2147483648 : i32) : i32
    %14 = llvm.mlir.undef : vector<4xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %13, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %2, %20[%21 : i32] : vector<4xi32>
    %23 = llvm.add %12, %arg0  : vector<4xi32>
    %24 = llvm.xor %22, %23  : vector<4xi32>
    llvm.return %24 : vector<4xi32>
  }
}
