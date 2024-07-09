module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @p(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @p_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg2, %0  : vector<2xi32>
    %2 = llvm.or %1, %arg0  : vector<2xi32>
    %3 = llvm.or %arg1, %arg2  : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @p_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.xor %arg2, %8  : vector<3xi32>
    %10 = llvm.or %9, %arg0  : vector<3xi32>
    %11 = llvm.or %arg1, %arg2  : vector<3xi32>
    %12 = llvm.and %10, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }
  llvm.func @p_constmask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @p_constmask_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-65281> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.or %arg1, %1  : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @p_constmask_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-65281, -16776961]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65280, 16776960]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.or %arg1, %1  : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @p_constmask_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(65280 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.or %arg0, %8  : vector<3xi32>
    %18 = llvm.or %arg1, %16  : vector<3xi32>
    %19 = llvm.and %17, %18  : vector<3xi32>
    llvm.return %19 : vector<3xi32>
  }
  llvm.func @gen32() -> i32
  llvm.func @p_commutative0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @p_commutative1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @p_commutative2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @p_commutative3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @p_commutative4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @p_commutative5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @p_commutative6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @p_constmask_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @use32(i32)
  llvm.func @n0_oneuse_of_neg_is_ok_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n0_oneuse_1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n0_oneuse_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n0_oneuse_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n0_oneuse_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n0_oneuse_5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n0_oneuse_6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n0_constmask_oneuse_0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n0_constmask_oneuse_1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n0_constmask_oneuse_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @n1_badxor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @n2_badmask(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg3, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg2, %arg1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @n3_constmask_badmask_set(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65281 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @n3_constmask_badmask_unset(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65024 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @n3_constmask_samemask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.or %arg1, %0  : i32
    %3 = llvm.and %1, %2  : i32
    llvm.return %3 : i32
  }
}
