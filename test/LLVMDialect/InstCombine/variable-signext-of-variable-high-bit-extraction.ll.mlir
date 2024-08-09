module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use16(i16)
  llvm.func @use32(i32)
  llvm.func @use64(i64)
  llvm.func @t0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @t0_zext_of_nbits(%arg0: i64, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(64 : i16) : i16
    %1 = llvm.mlir.constant(32 : i16) : i16
    %2 = llvm.zext %arg1 : i8 to i16
    llvm.call @use16(%2) : (i16) -> ()
    %3 = llvm.sub %0, %2  : i16
    llvm.call @use16(%3) : (i16) -> ()
    %4 = llvm.zext %3 : i16 to i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.lshr %arg0, %4  : i64
    llvm.call @use64(%5) : (i64) -> ()
    %6 = llvm.trunc %5 : i64 to i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.sub %1, %2  : i16
    llvm.call @use16(%7) : (i16) -> ()
    %8 = llvm.zext %7 : i16 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.shl %6, %8  : i32
    %10 = llvm.ashr %9, %8  : i32
    llvm.return %10 : i32
  }
  llvm.func @t0_exact(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @t1_redundant_sext(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.ashr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @t2_notrunc(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.lshr %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.shl %2, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.ashr %4, %3  : i64
    llvm.return %5 : i64
  }
  llvm.func @t3_notrunc_redundant_sext(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.ashr %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.shl %2, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.ashr %4, %3  : i64
    llvm.return %5 : i64
  }
  llvm.func @t4_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg1  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.lshr %arg0, %3  : vector<2xi64>
    %5 = llvm.trunc %4 : vector<2xi64> to vector<2xi32>
    %6 = llvm.sub %1, %arg1  : vector<2xi32>
    %7 = llvm.shl %5, %6  : vector<2xi32>
    %8 = llvm.ashr %7, %6  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @t5_vec_poison(%arg0: vector<3xi64>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(32 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %9, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %0, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.mlir.undef : vector<3xi32>
    %18 = llvm.mlir.constant(0 : i32) : i32
    %19 = llvm.insertelement %0, %17[%18 : i32] : vector<3xi32>
    %20 = llvm.mlir.constant(1 : i32) : i32
    %21 = llvm.insertelement %9, %19[%20 : i32] : vector<3xi32>
    %22 = llvm.mlir.constant(2 : i32) : i32
    %23 = llvm.insertelement %9, %21[%22 : i32] : vector<3xi32>
    %24 = llvm.sub %8, %arg1  : vector<3xi32>
    %25 = llvm.zext %24 : vector<3xi32> to vector<3xi64>
    %26 = llvm.lshr %arg0, %25  : vector<3xi64>
    %27 = llvm.trunc %26 : vector<3xi64> to vector<3xi32>
    %28 = llvm.sub %16, %arg1  : vector<3xi32>
    %29 = llvm.sub %23, %arg1  : vector<3xi32>
    %30 = llvm.shl %27, %28  : vector<3xi32>
    %31 = llvm.ashr %30, %29  : vector<3xi32>
    llvm.return %31 : vector<3xi32>
  }
  llvm.func @t6_extrause_good0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @t7_extrause_good1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.sub %1, %arg1  : i32
    %8 = llvm.shl %5, %6  : i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.ashr %8, %7  : i32
    llvm.return %9 : i32
  }
  llvm.func @n8_extrause_bad(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @n9(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @n10(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @n11(%arg0: i64, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @n12(%arg0: i64, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    %7 = llvm.sub %1, %arg2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %5, %6  : i32
    %9 = llvm.ashr %8, %7  : i32
    llvm.return %9 : i32
  }
  llvm.func @n13(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.lshr %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @n13_extrause(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.lshr %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @n14(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.ashr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.lshr %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @n14_extrause(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.ashr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.lshr %7, %6  : i32
    llvm.return %8 : i32
  }
}
