module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @use64(i64)
  llvm.func @t0_basic(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %1, %4  : i64
    %6 = llvm.xor %5, %1  : i64
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %6, %arg0  : i64
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.shl %9, %7  : i32
    llvm.return %10 : i32
  }
  llvm.func @use8xi32(vector<8xi32>)
  llvm.func @use8xi64(vector<8xi64>)
  llvm.func @t1_vec_splat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    %4 = llvm.zext %3 : vector<8xi32> to vector<8xi64>
    %5 = llvm.shl %1, %4  : vector<8xi64>
    %6 = llvm.xor %5, %1  : vector<8xi64>
    %7 = llvm.sub %2, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%5) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%6) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%7) : (vector<8xi32>) -> ()
    %8 = llvm.and %6, %arg0  : vector<8xi64>
    %9 = llvm.trunc %8 : vector<8xi64> to vector<8xi32>
    %10 = llvm.shl %9, %7  : vector<8xi32>
    llvm.return %10 : vector<8xi32>
  }
  llvm.func @t2_vec_splat_poison(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<8xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<8xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<8xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<8xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<8xi32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<8xi32>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<8xi32>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<8xi32>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<8xi32>
    %19 = llvm.mlir.constant(-1 : i64) : i64
    %20 = llvm.mlir.poison : i64
    %21 = llvm.mlir.undef : vector<8xi64>
    %22 = llvm.mlir.constant(0 : i32) : i32
    %23 = llvm.insertelement %19, %21[%22 : i32] : vector<8xi64>
    %24 = llvm.mlir.constant(1 : i32) : i32
    %25 = llvm.insertelement %19, %23[%24 : i32] : vector<8xi64>
    %26 = llvm.mlir.constant(2 : i32) : i32
    %27 = llvm.insertelement %19, %25[%26 : i32] : vector<8xi64>
    %28 = llvm.mlir.constant(3 : i32) : i32
    %29 = llvm.insertelement %19, %27[%28 : i32] : vector<8xi64>
    %30 = llvm.mlir.constant(4 : i32) : i32
    %31 = llvm.insertelement %19, %29[%30 : i32] : vector<8xi64>
    %32 = llvm.mlir.constant(5 : i32) : i32
    %33 = llvm.insertelement %19, %31[%32 : i32] : vector<8xi64>
    %34 = llvm.mlir.constant(6 : i32) : i32
    %35 = llvm.insertelement %20, %33[%34 : i32] : vector<8xi64>
    %36 = llvm.mlir.constant(7 : i32) : i32
    %37 = llvm.insertelement %19, %35[%36 : i32] : vector<8xi64>
    %38 = llvm.mlir.constant(32 : i32) : i32
    %39 = llvm.mlir.undef : vector<8xi32>
    %40 = llvm.mlir.constant(0 : i32) : i32
    %41 = llvm.insertelement %38, %39[%40 : i32] : vector<8xi32>
    %42 = llvm.mlir.constant(1 : i32) : i32
    %43 = llvm.insertelement %38, %41[%42 : i32] : vector<8xi32>
    %44 = llvm.mlir.constant(2 : i32) : i32
    %45 = llvm.insertelement %38, %43[%44 : i32] : vector<8xi32>
    %46 = llvm.mlir.constant(3 : i32) : i32
    %47 = llvm.insertelement %38, %45[%46 : i32] : vector<8xi32>
    %48 = llvm.mlir.constant(4 : i32) : i32
    %49 = llvm.insertelement %38, %47[%48 : i32] : vector<8xi32>
    %50 = llvm.mlir.constant(5 : i32) : i32
    %51 = llvm.insertelement %38, %49[%50 : i32] : vector<8xi32>
    %52 = llvm.mlir.constant(6 : i32) : i32
    %53 = llvm.insertelement %1, %51[%52 : i32] : vector<8xi32>
    %54 = llvm.mlir.constant(7 : i32) : i32
    %55 = llvm.insertelement %38, %53[%54 : i32] : vector<8xi32>
    %56 = llvm.add %arg1, %18  : vector<8xi32>
    %57 = llvm.zext %56 : vector<8xi32> to vector<8xi64>
    %58 = llvm.shl %37, %57  : vector<8xi64>
    %59 = llvm.xor %58, %37  : vector<8xi64>
    %60 = llvm.sub %55, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%56) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%57) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%58) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%59) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%60) : (vector<8xi32>) -> ()
    %61 = llvm.and %59, %arg0  : vector<8xi64>
    %62 = llvm.trunc %61 : vector<8xi64> to vector<8xi32>
    %63 = llvm.shl %62, %60  : vector<8xi32>
    llvm.return %63 : vector<8xi32>
  }
  llvm.func @t3_vec_nonsplat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-33, -32, -31, -1, 0, 1, 31, 32]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    %4 = llvm.zext %3 : vector<8xi32> to vector<8xi64>
    %5 = llvm.shl %1, %4  : vector<8xi64>
    %6 = llvm.xor %5, %1  : vector<8xi64>
    %7 = llvm.sub %2, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%5) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%6) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%7) : (vector<8xi32>) -> ()
    %8 = llvm.and %6, %arg0  : vector<8xi64>
    %9 = llvm.trunc %8 : vector<8xi64> to vector<8xi32>
    %10 = llvm.shl %9, %7  : vector<8xi32>
    llvm.return %10 : vector<8xi32>
  }
  llvm.func @t4_allones_trunc(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(4294967295 : i64) : i64
    %3 = llvm.mlir.constant(32 : i32) : i32
    %4 = llvm.add %arg1, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.shl %1, %5  : i64
    %7 = llvm.xor %6, %2  : i64
    %8 = llvm.sub %3, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use64(%7) : (i64) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %7, %arg0  : i64
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.shl %10, %8  : i32
    llvm.return %11 : i32
  }
  llvm.func @n5_extrause0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %1, %4  : i64
    %6 = llvm.xor %5, %1  : i64
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %6, %arg0  : i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.trunc %8 : i64 to i32
    %10 = llvm.shl %9, %7  : i32
    llvm.return %10 : i32
  }
  llvm.func @n6_extrause1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %1, %4  : i64
    %6 = llvm.xor %5, %1  : i64
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %6, %arg0  : i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.shl %9, %7  : i32
    llvm.return %10 : i32
  }
  llvm.func @n7_extrause2(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %1, %4  : i64
    %6 = llvm.xor %5, %1  : i64
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %6, %arg0  : i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.shl %9, %7  : i32
    llvm.return %10 : i32
  }
}
