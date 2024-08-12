module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @splat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @splat_undef(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.undef : i4
    %2 = llvm.mlir.undef : vector<3xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi4>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi4>
    %9 = llvm.xor %arg0, %arg1  : vector<3xi4>
    %10 = llvm.and %9, %8  : vector<3xi4>
    %11 = llvm.xor %10, %arg1  : vector<3xi4>
    llvm.return %11 : vector<3xi4>
  }
  llvm.func @nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @in_constant_varx_mone(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %5, %1  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @in_constant_varx_14(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %5, %1  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @in_constant_varx_14_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, 7]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(1 : i4) : i4
    %4 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.xor %arg0, %2  : vector<2xi4>
    %6 = llvm.and %5, %4  : vector<2xi4>
    %7 = llvm.xor %6, %2  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }
  llvm.func @in_constant_varx_14_undef(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.undef : i4
    %2 = llvm.mlir.constant(-2 : i4) : i4
    %3 = llvm.mlir.undef : vector<3xi4>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi4>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi4>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi4>
    %10 = llvm.mlir.constant(1 : i4) : i4
    %11 = llvm.mlir.undef : vector<3xi4>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi4>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi4>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi4>
    %18 = llvm.xor %arg0, %9  : vector<3xi4>
    %19 = llvm.and %18, %17  : vector<3xi4>
    %20 = llvm.xor %19, %9  : vector<3xi4>
    llvm.return %20 : vector<3xi4>
  }
  llvm.func @in_constant_mone_vary(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %5, %arg0  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @in_constant_14_vary(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %5, %arg0  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @in_constant_14_vary_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, 7]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(1 : i4) : i4
    %4 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.xor %arg0, %2  : vector<2xi4>
    %6 = llvm.and %5, %4  : vector<2xi4>
    %7 = llvm.xor %6, %arg0  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }
  llvm.func @in_constant_14_vary_undef(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.undef : i4
    %2 = llvm.mlir.constant(-2 : i4) : i4
    %3 = llvm.mlir.undef : vector<3xi4>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi4>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi4>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi4>
    %10 = llvm.mlir.constant(1 : i4) : i4
    %11 = llvm.mlir.undef : vector<3xi4>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi4>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi4>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi4>
    %18 = llvm.xor %arg0, %9  : vector<3xi4>
    %19 = llvm.and %18, %17  : vector<3xi4>
    %20 = llvm.xor %19, %arg0  : vector<3xi4>
    llvm.return %20 : vector<3xi4>
  }
  llvm.func @gen4() -> vector<2xi4>
  llvm.func @c_1_0_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @c_0_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg0  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @c_0_0_1() -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.call @gen4() : () -> vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.xor %2, %3  : vector<2xi4>
    %5 = llvm.and %4, %1  : vector<2xi4>
    %6 = llvm.xor %3, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @c_1_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg0  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @c_1_0_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.call @gen4() : () -> vector<2xi4>
    %3 = llvm.xor %2, %arg0  : vector<2xi4>
    %4 = llvm.and %3, %1  : vector<2xi4>
    %5 = llvm.xor %2, %4  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @c_0_1_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.call @gen4() : () -> vector<2xi4>
    %3 = llvm.xor %2, %arg0  : vector<2xi4>
    %4 = llvm.and %3, %1  : vector<2xi4>
    %5 = llvm.xor %2, %4  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @c_1_1_1() -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.call @gen4() : () -> vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.xor %3, %2  : vector<2xi4>
    %5 = llvm.and %4, %1  : vector<2xi4>
    %6 = llvm.xor %2, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @commutativity_constant_14_vary(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %arg0, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @use4(vector<2xi4>)
  llvm.func @n_oneuse_D(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.call @use4(%2) : (vector<2xi4>) -> ()
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @n_oneuse_A(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.call @use4(%3) : (vector<2xi4>) -> ()
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @n_oneuse_AD(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.call @use4(%2) : (vector<2xi4>) -> ()
    llvm.call @use4(%3) : (vector<2xi4>) -> ()
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @n_var_mask(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %1 = llvm.and %0, %arg2  : vector<2xi4>
    %2 = llvm.xor %1, %arg1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }
  llvm.func @n_differenty(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, 7]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(1 : i4) : i4
    %4 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.mlir.constant(dense<[7, -2]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.xor %arg0, %2  : vector<2xi4>
    %7 = llvm.and %6, %4  : vector<2xi4>
    %8 = llvm.xor %7, %5  : vector<2xi4>
    llvm.return %8 : vector<2xi4>
  }
}
