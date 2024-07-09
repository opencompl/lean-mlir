module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @use64(i64)
  llvm.func @t0_basic(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.shl %0, %3  : i64
    %5 = llvm.add %4, %1  : i64
    %6 = llvm.sub %2, %arg1  : i32
    %7 = llvm.and %5, %arg0  : i64
    llvm.call @use32(%arg1) : (i32) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.shl %8, %6  : i32
    llvm.return %9 : i32
  }
  llvm.func @use8xi32(vector<8xi32>)
  llvm.func @use8xi64(vector<8xi64>)
  llvm.func @t1_vec_splat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<8xi64>) : vector<8xi64>
    %1 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %4 = llvm.shl %0, %3  : vector<8xi64>
    %5 = llvm.add %4, %1  : vector<8xi64>
    %6 = llvm.sub %2, %arg1  : vector<8xi32>
    %7 = llvm.and %5, %arg0  : vector<8xi64>
    llvm.call @use8xi32(%arg1) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%3) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%5) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%6) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%7) : (vector<8xi64>) -> ()
    %8 = llvm.trunc %7 : vector<8xi64> to vector<8xi32>
    %9 = llvm.shl %8, %6  : vector<8xi32>
    llvm.return %9 : vector<8xi32>
  }
  llvm.func @t2_vec_splat_poison(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<8xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<8xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<8xi64>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<8xi64>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<8xi64>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<8xi64>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<8xi64>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<8xi64>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<8xi64>
    %19 = llvm.mlir.constant(-1 : i64) : i64
    %20 = llvm.mlir.undef : vector<8xi64>
    %21 = llvm.mlir.constant(0 : i32) : i32
    %22 = llvm.insertelement %19, %20[%21 : i32] : vector<8xi64>
    %23 = llvm.mlir.constant(1 : i32) : i32
    %24 = llvm.insertelement %19, %22[%23 : i32] : vector<8xi64>
    %25 = llvm.mlir.constant(2 : i32) : i32
    %26 = llvm.insertelement %19, %24[%25 : i32] : vector<8xi64>
    %27 = llvm.mlir.constant(3 : i32) : i32
    %28 = llvm.insertelement %19, %26[%27 : i32] : vector<8xi64>
    %29 = llvm.mlir.constant(4 : i32) : i32
    %30 = llvm.insertelement %19, %28[%29 : i32] : vector<8xi64>
    %31 = llvm.mlir.constant(5 : i32) : i32
    %32 = llvm.insertelement %19, %30[%31 : i32] : vector<8xi64>
    %33 = llvm.mlir.constant(6 : i32) : i32
    %34 = llvm.insertelement %1, %32[%33 : i32] : vector<8xi64>
    %35 = llvm.mlir.constant(7 : i32) : i32
    %36 = llvm.insertelement %19, %34[%35 : i32] : vector<8xi64>
    %37 = llvm.mlir.constant(32 : i32) : i32
    %38 = llvm.mlir.poison : i32
    %39 = llvm.mlir.undef : vector<8xi32>
    %40 = llvm.mlir.constant(0 : i32) : i32
    %41 = llvm.insertelement %37, %39[%40 : i32] : vector<8xi32>
    %42 = llvm.mlir.constant(1 : i32) : i32
    %43 = llvm.insertelement %37, %41[%42 : i32] : vector<8xi32>
    %44 = llvm.mlir.constant(2 : i32) : i32
    %45 = llvm.insertelement %37, %43[%44 : i32] : vector<8xi32>
    %46 = llvm.mlir.constant(3 : i32) : i32
    %47 = llvm.insertelement %37, %45[%46 : i32] : vector<8xi32>
    %48 = llvm.mlir.constant(4 : i32) : i32
    %49 = llvm.insertelement %37, %47[%48 : i32] : vector<8xi32>
    %50 = llvm.mlir.constant(5 : i32) : i32
    %51 = llvm.insertelement %37, %49[%50 : i32] : vector<8xi32>
    %52 = llvm.mlir.constant(6 : i32) : i32
    %53 = llvm.insertelement %38, %51[%52 : i32] : vector<8xi32>
    %54 = llvm.mlir.constant(7 : i32) : i32
    %55 = llvm.insertelement %37, %53[%54 : i32] : vector<8xi32>
    %56 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %57 = llvm.shl %18, %56  : vector<8xi64>
    %58 = llvm.add %57, %36  : vector<8xi64>
    %59 = llvm.sub %55, %arg1  : vector<8xi32>
    %60 = llvm.and %58, %arg0  : vector<8xi64>
    llvm.call @use8xi32(%arg1) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%56) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%57) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%58) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%59) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%60) : (vector<8xi64>) -> ()
    %61 = llvm.trunc %60 : vector<8xi64> to vector<8xi32>
    %62 = llvm.shl %61, %59  : vector<8xi32>
    llvm.return %62 : vector<8xi32>
  }
  llvm.func @t3_vec_nonsplat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<8xi64>) : vector<8xi64>
    %1 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %4 = llvm.shl %0, %3  : vector<8xi64>
    %5 = llvm.add %4, %1  : vector<8xi64>
    %6 = llvm.sub %2, %arg1  : vector<8xi32>
    %7 = llvm.and %5, %arg0  : vector<8xi64>
    llvm.call @use8xi32(%arg1) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%3) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%5) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%6) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%7) : (vector<8xi64>) -> ()
    %8 = llvm.trunc %7 : vector<8xi64> to vector<8xi32>
    %9 = llvm.shl %8, %6  : vector<8xi32>
    llvm.return %9 : vector<8xi32>
  }
  llvm.func @n4_extrause(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.shl %0, %3  : i64
    %5 = llvm.add %4, %1  : i64
    %6 = llvm.sub %2, %arg1  : i32
    %7 = llvm.and %5, %arg0  : i64
    llvm.call @use32(%arg1) : (i32) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.shl %8, %6  : i32
    llvm.return %9 : i32
  }
}
