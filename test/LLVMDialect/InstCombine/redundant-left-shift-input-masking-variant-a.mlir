module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.add %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @t1_bigger_shift(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(33 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.add %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @t2_bigger_mask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.shl %0, %3  : i32
    %5 = llvm.add %4, %1 overflow<nsw>  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @use3xi32(vector<3xi32>)
  llvm.func @t3_vec_splat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %4 = llvm.mlir.constant(dense<32> : vector<3xi32>) : vector<3xi32>
    %5 = llvm.add %arg1, %1  : vector<3xi32>
    %6 = llvm.shl %2, %5  : vector<3xi32>
    %7 = llvm.add %6, %3 overflow<nsw>  : vector<3xi32>
    %8 = llvm.and %7, %arg0  : vector<3xi32>
    %9 = llvm.sub %4, %arg1  : vector<3xi32>
    llvm.call @use3xi32(%5) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%6) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%7) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%8) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%9) : (vector<3xi32>) -> ()
    %10 = llvm.shl %8, %9  : vector<3xi32>
    llvm.return %10 : vector<3xi32>
  }
  llvm.func @t4_vec_nonsplat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[-1, 0, 1]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.mlir.constant(dense<[33, 32, 32]> : vector<3xi32>) : vector<3xi32>
    %4 = llvm.add %arg1, %0  : vector<3xi32>
    %5 = llvm.shl %1, %4  : vector<3xi32>
    %6 = llvm.add %5, %2 overflow<nsw>  : vector<3xi32>
    %7 = llvm.and %6, %arg0  : vector<3xi32>
    %8 = llvm.sub %3, %arg1  : vector<3xi32>
    llvm.call @use3xi32(%4) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%5) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%6) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%7) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%8) : (vector<3xi32>) -> ()
    %9 = llvm.shl %7, %8  : vector<3xi32>
    llvm.return %9 : vector<3xi32>
  }
  llvm.func @t5_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
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
    %17 = llvm.mlir.constant(-1 : i32) : i32
    %18 = llvm.mlir.undef : vector<3xi32>
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.insertelement %17, %18[%19 : i32] : vector<3xi32>
    %21 = llvm.mlir.constant(1 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<3xi32>
    %23 = llvm.mlir.constant(2 : i32) : i32
    %24 = llvm.insertelement %17, %22[%23 : i32] : vector<3xi32>
    %25 = llvm.mlir.constant(32 : i32) : i32
    %26 = llvm.mlir.undef : vector<3xi32>
    %27 = llvm.mlir.constant(0 : i32) : i32
    %28 = llvm.insertelement %25, %26[%27 : i32] : vector<3xi32>
    %29 = llvm.mlir.constant(1 : i32) : i32
    %30 = llvm.insertelement %1, %28[%29 : i32] : vector<3xi32>
    %31 = llvm.mlir.constant(2 : i32) : i32
    %32 = llvm.insertelement %25, %30[%31 : i32] : vector<3xi32>
    %33 = llvm.add %arg1, %8  : vector<3xi32>
    %34 = llvm.shl %16, %33  : vector<3xi32>
    %35 = llvm.add %34, %24 overflow<nsw>  : vector<3xi32>
    %36 = llvm.and %35, %arg0  : vector<3xi32>
    %37 = llvm.sub %32, %arg1  : vector<3xi32>
    llvm.call @use3xi32(%33) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%34) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%35) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%36) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%37) : (vector<3xi32>) -> ()
    %38 = llvm.shl %36, %37  : vector<3xi32>
    llvm.return %38 : vector<3xi32>
  }
  llvm.func @gen32() -> i32
  llvm.func @t6_commutativity0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.call @gen32() : () -> i32
    %4 = llvm.shl %0, %arg0  : i32
    %5 = llvm.add %4, %1 overflow<nsw>  : i32
    %6 = llvm.and %3, %5  : i32
    %7 = llvm.sub %2, %arg0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @t7_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.add %3, %1 overflow<nsw>  : i32
    %5 = llvm.shl %0, %arg1  : i32
    %6 = llvm.add %5, %1 overflow<nsw>  : i32
    %7 = llvm.and %6, %4  : i32
    %8 = llvm.sub %2, %arg0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.shl %7, %8  : i32
    llvm.return %9 : i32
  }
  llvm.func @t8_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.add %3, %1 overflow<nsw>  : i32
    %5 = llvm.shl %0, %arg1  : i32
    %6 = llvm.add %5, %1 overflow<nsw>  : i32
    %7 = llvm.and %6, %4  : i32
    %8 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.shl %7, %8  : i32
    llvm.return %9 : i32
  }
  llvm.func @t9_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.add %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6 overflow<nuw>  : i32
    llvm.return %7 : i32
  }
  llvm.func @t10_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.add %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6 overflow<nsw>  : i32
    llvm.return %7 : i32
  }
  llvm.func @t11_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.add %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6 overflow<nsw, nuw>  : i32
    llvm.return %7 : i32
  }
  llvm.func @n12_not_minus_one(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.add %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @n13_not_minus_one(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.add %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.return %7 : i32
  }
}
