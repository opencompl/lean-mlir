module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @use64(i64)
  llvm.func @t0_basic(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.mlir.constant(32 : i32) : i32
    %4 = llvm.add %arg1, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.shl %1, %5  : i64
    %7 = llvm.add %6, %2  : i64
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
  llvm.func @use8xi32(vector<8xi32>)
  llvm.func @use8xi64(vector<8xi64>)
  llvm.func @t1_vec_splat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %3 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %4 = llvm.add %arg1, %0  : vector<8xi32>
    %5 = llvm.zext %4 : vector<8xi32> to vector<8xi64>
    %6 = llvm.shl %1, %5  : vector<8xi64>
    %7 = llvm.add %6, %2  : vector<8xi64>
    %8 = llvm.sub %3, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%4) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%5) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%6) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%7) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%8) : (vector<8xi32>) -> ()
    %9 = llvm.and %7, %arg0  : vector<8xi64>
    %10 = llvm.trunc %9 : vector<8xi64> to vector<8xi32>
    %11 = llvm.shl %10, %8  : vector<8xi32>
    llvm.return %11 : vector<8xi32>
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
    %19 = llvm.mlir.constant(1 : i64) : i64
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
    %38 = llvm.mlir.constant(-1 : i64) : i64
    %39 = llvm.mlir.undef : vector<8xi64>
    %40 = llvm.mlir.constant(0 : i32) : i32
    %41 = llvm.insertelement %38, %39[%40 : i32] : vector<8xi64>
    %42 = llvm.mlir.constant(1 : i32) : i32
    %43 = llvm.insertelement %38, %41[%42 : i32] : vector<8xi64>
    %44 = llvm.mlir.constant(2 : i32) : i32
    %45 = llvm.insertelement %38, %43[%44 : i32] : vector<8xi64>
    %46 = llvm.mlir.constant(3 : i32) : i32
    %47 = llvm.insertelement %38, %45[%46 : i32] : vector<8xi64>
    %48 = llvm.mlir.constant(4 : i32) : i32
    %49 = llvm.insertelement %38, %47[%48 : i32] : vector<8xi64>
    %50 = llvm.mlir.constant(5 : i32) : i32
    %51 = llvm.insertelement %38, %49[%50 : i32] : vector<8xi64>
    %52 = llvm.mlir.constant(6 : i32) : i32
    %53 = llvm.insertelement %20, %51[%52 : i32] : vector<8xi64>
    %54 = llvm.mlir.constant(7 : i32) : i32
    %55 = llvm.insertelement %38, %53[%54 : i32] : vector<8xi64>
    %56 = llvm.mlir.constant(32 : i32) : i32
    %57 = llvm.mlir.undef : vector<8xi32>
    %58 = llvm.mlir.constant(0 : i32) : i32
    %59 = llvm.insertelement %56, %57[%58 : i32] : vector<8xi32>
    %60 = llvm.mlir.constant(1 : i32) : i32
    %61 = llvm.insertelement %56, %59[%60 : i32] : vector<8xi32>
    %62 = llvm.mlir.constant(2 : i32) : i32
    %63 = llvm.insertelement %56, %61[%62 : i32] : vector<8xi32>
    %64 = llvm.mlir.constant(3 : i32) : i32
    %65 = llvm.insertelement %56, %63[%64 : i32] : vector<8xi32>
    %66 = llvm.mlir.constant(4 : i32) : i32
    %67 = llvm.insertelement %56, %65[%66 : i32] : vector<8xi32>
    %68 = llvm.mlir.constant(5 : i32) : i32
    %69 = llvm.insertelement %56, %67[%68 : i32] : vector<8xi32>
    %70 = llvm.mlir.constant(6 : i32) : i32
    %71 = llvm.insertelement %1, %69[%70 : i32] : vector<8xi32>
    %72 = llvm.mlir.constant(7 : i32) : i32
    %73 = llvm.insertelement %56, %71[%72 : i32] : vector<8xi32>
    %74 = llvm.add %arg1, %18  : vector<8xi32>
    %75 = llvm.zext %74 : vector<8xi32> to vector<8xi64>
    %76 = llvm.shl %37, %75  : vector<8xi64>
    %77 = llvm.add %76, %55  : vector<8xi64>
    %78 = llvm.sub %73, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%74) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%75) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%76) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%77) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%78) : (vector<8xi32>) -> ()
    %79 = llvm.and %77, %arg0  : vector<8xi64>
    %80 = llvm.trunc %79 : vector<8xi64> to vector<8xi32>
    %81 = llvm.shl %80, %78  : vector<8xi32>
    llvm.return %81 : vector<8xi32>
  }
  llvm.func @t3_vec_nonsplat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-33, -32, -31, -1, 0, 1, 31, 32]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %3 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %4 = llvm.add %arg1, %0  : vector<8xi32>
    %5 = llvm.zext %4 : vector<8xi32> to vector<8xi64>
    %6 = llvm.shl %1, %5  : vector<8xi64>
    %7 = llvm.add %6, %2  : vector<8xi64>
    %8 = llvm.sub %3, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%4) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%5) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%6) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%7) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%8) : (vector<8xi32>) -> ()
    %9 = llvm.and %7, %arg0  : vector<8xi64>
    %10 = llvm.trunc %9 : vector<8xi64> to vector<8xi32>
    %11 = llvm.shl %10, %8  : vector<8xi32>
    llvm.return %11 : vector<8xi32>
  }
  llvm.func @n4_extrause0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.mlir.constant(32 : i32) : i32
    %4 = llvm.add %arg1, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.shl %1, %5  : i64
    %7 = llvm.add %6, %2  : i64
    %8 = llvm.sub %3, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use64(%7) : (i64) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %7, %arg0  : i64
    llvm.call @use64(%9) : (i64) -> ()
    %10 = llvm.trunc %9 : i64 to i32
    %11 = llvm.shl %10, %8  : i32
    llvm.return %11 : i32
  }
  llvm.func @n5_extrause1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.mlir.constant(32 : i32) : i32
    %4 = llvm.add %arg1, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.shl %1, %5  : i64
    %7 = llvm.add %6, %2  : i64
    %8 = llvm.sub %3, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use64(%7) : (i64) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %7, %arg0  : i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.shl %10, %8  : i32
    llvm.return %11 : i32
  }
  llvm.func @n6_extrause2(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.mlir.constant(32 : i32) : i32
    %4 = llvm.add %arg1, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.shl %1, %5  : i64
    %7 = llvm.add %6, %2  : i64
    %8 = llvm.sub %3, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use64(%7) : (i64) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %7, %arg0  : i64
    llvm.call @use64(%9) : (i64) -> ()
    %10 = llvm.trunc %9 : i64 to i32
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.shl %10, %8  : i32
    llvm.return %11 : i32
  }
}
