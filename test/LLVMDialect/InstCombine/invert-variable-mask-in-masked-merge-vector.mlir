module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @vector(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @vector_poison(%arg0: vector<3xi4>, %arg1: vector<3xi4>, %arg2: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.poison : i4
    %2 = llvm.mlir.undef : vector<3xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi4>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi4>
    %9 = llvm.xor %arg2, %8  : vector<3xi4>
    %10 = llvm.xor %arg0, %arg1  : vector<3xi4>
    %11 = llvm.and %10, %9  : vector<3xi4>
    %12 = llvm.xor %11, %arg1  : vector<3xi4>
    llvm.return %12 : vector<3xi4>
  }
  llvm.func @in_constant_varx_mone_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %1  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @in_constant_varx_6_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(6 : i4) : i4
    %3 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg1, %1  : vector<2xi4>
    %5 = llvm.xor %arg0, %3  : vector<2xi4>
    %6 = llvm.and %5, %4  : vector<2xi4>
    %7 = llvm.xor %6, %3  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }
  llvm.func @in_constant_varx_6_invmask_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(7 : i4) : i4
    %3 = llvm.mlir.constant(6 : i4) : i4
    %4 = llvm.mlir.constant(dense<[6, 7]> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.xor %arg1, %1  : vector<2xi4>
    %6 = llvm.xor %arg0, %4  : vector<2xi4>
    %7 = llvm.and %6, %5  : vector<2xi4>
    %8 = llvm.xor %7, %4  : vector<2xi4>
    llvm.return %8 : vector<2xi4>
  }
  llvm.func @in_constant_varx_6_invmask_poison(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.poison : i4
    %2 = llvm.mlir.undef : vector<3xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi4>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi4>
    %9 = llvm.mlir.constant(7 : i4) : i4
    %10 = llvm.mlir.constant(6 : i4) : i4
    %11 = llvm.mlir.undef : vector<3xi4>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi4>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi4>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %9, %15[%16 : i32] : vector<3xi4>
    %18 = llvm.xor %arg1, %8  : vector<3xi4>
    %19 = llvm.xor %arg0, %17  : vector<3xi4>
    %20 = llvm.and %19, %18  : vector<3xi4>
    %21 = llvm.xor %20, %17  : vector<3xi4>
    llvm.return %21 : vector<3xi4>
  }
  llvm.func @in_constant_mone_vary_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %1  : vector<2xi4>
    %3 = llvm.xor %1, %arg0  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg0  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @in_constant_6_vary_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(6 : i4) : i4
    %3 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg1, %1  : vector<2xi4>
    %5 = llvm.xor %arg0, %3  : vector<2xi4>
    %6 = llvm.and %5, %4  : vector<2xi4>
    %7 = llvm.xor %6, %arg0  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }
  llvm.func @in_constant_6_vary_invmask_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(7 : i4) : i4
    %3 = llvm.mlir.constant(6 : i4) : i4
    %4 = llvm.mlir.constant(dense<[6, 7]> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.xor %arg1, %1  : vector<2xi4>
    %6 = llvm.xor %arg0, %4  : vector<2xi4>
    %7 = llvm.and %6, %5  : vector<2xi4>
    %8 = llvm.xor %7, %arg0  : vector<2xi4>
    llvm.return %8 : vector<2xi4>
  }
  llvm.func @in_constant_6_vary_invmask_poison(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.poison : i4
    %2 = llvm.mlir.undef : vector<3xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi4>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi4>
    %9 = llvm.mlir.constant(6 : i4) : i4
    %10 = llvm.mlir.undef : vector<3xi4>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi4>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi4>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi4>
    %17 = llvm.xor %arg1, %8  : vector<3xi4>
    %18 = llvm.xor %arg0, %16  : vector<3xi4>
    %19 = llvm.and %18, %17  : vector<3xi4>
    %20 = llvm.xor %19, %arg0  : vector<3xi4>
    llvm.return %20 : vector<3xi4>
  }
  llvm.func @gen4() -> vector<2xi4>
  llvm.func @c_1_0_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @c_0_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg0  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @c_0_0_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %1  : vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.call @gen4() : () -> vector<2xi4>
    %5 = llvm.xor %3, %4  : vector<2xi4>
    %6 = llvm.and %5, %2  : vector<2xi4>
    %7 = llvm.xor %4, %6  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }
  llvm.func @c_1_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg0  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @c_1_0_1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %1  : vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.xor %3, %arg0  : vector<2xi4>
    %5 = llvm.and %4, %2  : vector<2xi4>
    %6 = llvm.xor %3, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @c_0_1_1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %1  : vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.xor %3, %arg0  : vector<2xi4>
    %5 = llvm.and %4, %2  : vector<2xi4>
    %6 = llvm.xor %3, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
  llvm.func @c_1_1_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %1  : vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.call @gen4() : () -> vector<2xi4>
    %5 = llvm.xor %4, %3  : vector<2xi4>
    %6 = llvm.and %5, %2  : vector<2xi4>
    %7 = llvm.xor %3, %6  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }
  llvm.func @commutativity_constant_varx_6_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(6 : i4) : i4
    %3 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg1, %1  : vector<2xi4>
    %5 = llvm.xor %arg0, %3  : vector<2xi4>
    %6 = llvm.and %4, %5  : vector<2xi4>
    %7 = llvm.xor %6, %3  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }
  llvm.func @commutativity_constant_6_vary_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(6 : i4) : i4
    %3 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg1, %1  : vector<2xi4>
    %5 = llvm.xor %arg0, %3  : vector<2xi4>
    %6 = llvm.and %4, %5  : vector<2xi4>
    %7 = llvm.xor %6, %arg0  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }
  llvm.func @use4(vector<2xi4>)
  llvm.func @n_oneuse_D_is_ok(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.call @use4(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @n_oneuse_A(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.call @use4(%4) : (vector<2xi4>) -> ()
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @n_oneuse_AD(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.call @use4(%3) : (vector<2xi4>) -> ()
    llvm.call @use4(%4) : (vector<2xi4>) -> ()
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @n_third_var(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg3, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg2  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @n_third_var_const(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(7 : i4) : i4
    %3 = llvm.mlir.constant(6 : i4) : i4
    %4 = llvm.mlir.constant(dense<[6, 7]> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.mlir.constant(dense<[7, 6]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.xor %arg2, %1  : vector<2xi4>
    %7 = llvm.xor %arg0, %4  : vector<2xi4>
    %8 = llvm.and %7, %6  : vector<2xi4>
    %9 = llvm.xor %8, %5  : vector<2xi4>
    llvm.return %9 : vector<2xi4>
  }
  llvm.func @n_badxor_splat(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @n_badxor(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.xor %arg2, %2  : vector<2xi4>
    %4 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %5, %arg1  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }
}
