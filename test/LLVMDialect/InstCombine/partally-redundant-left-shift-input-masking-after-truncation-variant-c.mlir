module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @use64(i64)
  llvm.func @t0_basic(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(-33 : i32) : i32
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.lshr %0, %2  : i64
    %4 = llvm.add %arg1, %1  : i32
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %3, %arg0  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.shl %6, %4  : i32
    llvm.return %7 : i32
  }
  llvm.func @use8xi32(vector<8xi32>)
  llvm.func @use8xi64(vector<8xi64>)
  llvm.func @t1_vec_splat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %1 = llvm.mlir.constant(dense<-33> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %3 = llvm.lshr %0, %2  : vector<8xi64>
    %4 = llvm.add %arg1, %1  : vector<8xi32>
    llvm.call @use8xi64(%2) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%3) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%4) : (vector<8xi32>) -> ()
    %5 = llvm.and %3, %arg0  : vector<8xi64>
    %6 = llvm.trunc %5 : vector<8xi64> to vector<8xi32>
    %7 = llvm.shl %6, %4  : vector<8xi32>
    llvm.return %7 : vector<8xi32>
  }
  llvm.func @t2_vec_splat_poison(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i64) : i64
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
    %19 = llvm.mlir.constant(-33 : i32) : i32
    %20 = llvm.mlir.poison : i32
    %21 = llvm.mlir.undef : vector<8xi32>
    %22 = llvm.mlir.constant(0 : i32) : i32
    %23 = llvm.insertelement %19, %21[%22 : i32] : vector<8xi32>
    %24 = llvm.mlir.constant(1 : i32) : i32
    %25 = llvm.insertelement %19, %23[%24 : i32] : vector<8xi32>
    %26 = llvm.mlir.constant(2 : i32) : i32
    %27 = llvm.insertelement %19, %25[%26 : i32] : vector<8xi32>
    %28 = llvm.mlir.constant(3 : i32) : i32
    %29 = llvm.insertelement %19, %27[%28 : i32] : vector<8xi32>
    %30 = llvm.mlir.constant(4 : i32) : i32
    %31 = llvm.insertelement %19, %29[%30 : i32] : vector<8xi32>
    %32 = llvm.mlir.constant(5 : i32) : i32
    %33 = llvm.insertelement %19, %31[%32 : i32] : vector<8xi32>
    %34 = llvm.mlir.constant(6 : i32) : i32
    %35 = llvm.insertelement %20, %33[%34 : i32] : vector<8xi32>
    %36 = llvm.mlir.constant(7 : i32) : i32
    %37 = llvm.insertelement %19, %35[%36 : i32] : vector<8xi32>
    %38 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %39 = llvm.lshr %18, %38  : vector<8xi64>
    %40 = llvm.add %arg1, %37  : vector<8xi32>
    llvm.call @use8xi64(%38) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%39) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%40) : (vector<8xi32>) -> ()
    %41 = llvm.and %39, %arg0  : vector<8xi64>
    %42 = llvm.trunc %41 : vector<8xi64> to vector<8xi32>
    %43 = llvm.shl %42, %40  : vector<8xi32>
    llvm.return %43 : vector<8xi32>
  }
  llvm.func @t3_vec_nonsplat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i64) : i64
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
    %19 = llvm.mlir.constant(65 : i32) : i32
    %20 = llvm.mlir.poison : i32
    %21 = llvm.mlir.constant(64 : i32) : i32
    %22 = llvm.mlir.constant(63 : i32) : i32
    %23 = llvm.mlir.constant(-32 : i32) : i32
    %24 = llvm.mlir.constant(-33 : i32) : i32
    %25 = llvm.mlir.constant(-63 : i32) : i32
    %26 = llvm.mlir.constant(-64 : i32) : i32
    %27 = llvm.mlir.undef : vector<8xi32>
    %28 = llvm.mlir.constant(0 : i32) : i32
    %29 = llvm.insertelement %26, %27[%28 : i32] : vector<8xi32>
    %30 = llvm.mlir.constant(1 : i32) : i32
    %31 = llvm.insertelement %25, %29[%30 : i32] : vector<8xi32>
    %32 = llvm.mlir.constant(2 : i32) : i32
    %33 = llvm.insertelement %24, %31[%32 : i32] : vector<8xi32>
    %34 = llvm.mlir.constant(3 : i32) : i32
    %35 = llvm.insertelement %23, %33[%34 : i32] : vector<8xi32>
    %36 = llvm.mlir.constant(4 : i32) : i32
    %37 = llvm.insertelement %22, %35[%36 : i32] : vector<8xi32>
    %38 = llvm.mlir.constant(5 : i32) : i32
    %39 = llvm.insertelement %21, %37[%38 : i32] : vector<8xi32>
    %40 = llvm.mlir.constant(6 : i32) : i32
    %41 = llvm.insertelement %20, %39[%40 : i32] : vector<8xi32>
    %42 = llvm.mlir.constant(7 : i32) : i32
    %43 = llvm.insertelement %19, %41[%42 : i32] : vector<8xi32>
    %44 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %45 = llvm.lshr %18, %44  : vector<8xi64>
    %46 = llvm.add %arg1, %43  : vector<8xi32>
    llvm.call @use8xi64(%44) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%45) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%46) : (vector<8xi32>) -> ()
    %47 = llvm.and %45, %arg0  : vector<8xi64>
    %48 = llvm.trunc %47 : vector<8xi64> to vector<8xi32>
    %49 = llvm.shl %48, %46  : vector<8xi32>
    llvm.return %49 : vector<8xi32>
  }
  llvm.func @n4_extrause0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(-33 : i32) : i32
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.lshr %0, %2  : i64
    %4 = llvm.add %arg1, %1  : i32
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %3, %arg0  : i64
    llvm.call @use64(%5) : (i64) -> ()
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.shl %6, %4  : i32
    llvm.return %7 : i32
  }
  llvm.func @n5_extrause1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(-33 : i32) : i32
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.lshr %0, %2  : i64
    %4 = llvm.add %arg1, %1  : i32
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %3, %arg0  : i64
    %6 = llvm.trunc %5 : i64 to i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %6, %4  : i32
    llvm.return %7 : i32
  }
  llvm.func @n6_extrause2(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(-33 : i32) : i32
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.lshr %0, %2  : i64
    %4 = llvm.add %arg1, %1  : i32
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %3, %arg0  : i64
    llvm.call @use64(%5) : (i64) -> ()
    %6 = llvm.trunc %5 : i64 to i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %6, %4  : i32
    llvm.return %7 : i32
  }
}
