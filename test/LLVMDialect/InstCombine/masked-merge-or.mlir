module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @p(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @p_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32> {llvm.noundef}) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %arg2  : vector<2xi32>
    %2 = llvm.xor %arg2, %0  : vector<2xi32>
    %3 = llvm.and %2, %arg1  : vector<2xi32>
    %4 = llvm.or %1, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @p_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32> {llvm.noundef}) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.and %arg0, %arg2  : vector<3xi32>
    %10 = llvm.xor %arg2, %8  : vector<3xi32>
    %11 = llvm.and %10, %arg1  : vector<3xi32>
    %12 = llvm.or %9, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }
  llvm.func @p_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32> {llvm.noundef}) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.and %arg0, %arg2  : vector<3xi32>
    %10 = llvm.xor %arg2, %8  : vector<3xi32>
    %11 = llvm.and %10, %arg1  : vector<3xi32>
    %12 = llvm.or %9, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }
  llvm.func @p_constmask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @p_constmask_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-65281> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @p_constmask_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65280, 16776960]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65281, -16776961]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @p_constmask_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(-65281 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %8  : vector<3xi32>
    %18 = llvm.and %arg1, %16  : vector<3xi32>
    %19 = llvm.or %17, %18  : vector<3xi32>
    llvm.return %19 : vector<3xi32>
  }
  llvm.func @p_constmask2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(61440 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @p_constmask2_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<61440> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-65281> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @p_constmask2_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[61440, 16711680]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65281, -16776961]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @p_constmask2_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(61440 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(-65281 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %8  : vector<3xi32>
    %18 = llvm.and %arg1, %16  : vector<3xi32>
    %19 = llvm.or %17, %18  : vector<3xi32>
    llvm.return %19 : vector<3xi32>
  }
  llvm.func @gen32() -> i32
  llvm.func @p_commutative0(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @p_commutative1(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.or %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @p_commutative2(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @p_commutative3(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.or %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @p_commutative4(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @p_commutative5(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @p_commutative6(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @p_constmask_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @use32(i32)
  llvm.func @n0_oneuse(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n0_constmask_oneuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n1_badxor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @n2_badmask(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg0  : i32
    %2 = llvm.xor %arg3, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @n3_constmask_badmask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65280 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @n3_constmask_samemask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }
}
