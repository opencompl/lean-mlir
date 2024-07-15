module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.shl %1, %3  : i32
    %5 = llvm.add %4, %0  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %6, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @use8xi32(vector<8xi32>)
  llvm.func @t1_vec_splat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    %4 = llvm.shl %1, %3  : vector<8xi32>
    %5 = llvm.add %4, %0  : vector<8xi32>
    %6 = llvm.and %5, %arg0  : vector<8xi32>
    %7 = llvm.sub %2, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%4) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%5) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%7) : (vector<8xi32>) -> ()
    %8 = llvm.shl %6, %7  : vector<8xi32>
    llvm.return %8 : vector<8xi32>
  }
  llvm.func @t1_vec_splat_poison(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
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
    %19 = llvm.mlir.constant(1 : i32) : i32
    %20 = llvm.mlir.undef : vector<8xi32>
    %21 = llvm.mlir.constant(0 : i32) : i32
    %22 = llvm.insertelement %19, %20[%21 : i32] : vector<8xi32>
    %23 = llvm.mlir.constant(1 : i32) : i32
    %24 = llvm.insertelement %19, %22[%23 : i32] : vector<8xi32>
    %25 = llvm.mlir.constant(2 : i32) : i32
    %26 = llvm.insertelement %19, %24[%25 : i32] : vector<8xi32>
    %27 = llvm.mlir.constant(3 : i32) : i32
    %28 = llvm.insertelement %19, %26[%27 : i32] : vector<8xi32>
    %29 = llvm.mlir.constant(4 : i32) : i32
    %30 = llvm.insertelement %19, %28[%29 : i32] : vector<8xi32>
    %31 = llvm.mlir.constant(5 : i32) : i32
    %32 = llvm.insertelement %19, %30[%31 : i32] : vector<8xi32>
    %33 = llvm.mlir.constant(6 : i32) : i32
    %34 = llvm.insertelement %1, %32[%33 : i32] : vector<8xi32>
    %35 = llvm.mlir.constant(7 : i32) : i32
    %36 = llvm.insertelement %19, %34[%35 : i32] : vector<8xi32>
    %37 = llvm.mlir.constant(32 : i32) : i32
    %38 = llvm.mlir.undef : vector<8xi32>
    %39 = llvm.mlir.constant(0 : i32) : i32
    %40 = llvm.insertelement %37, %38[%39 : i32] : vector<8xi32>
    %41 = llvm.mlir.constant(1 : i32) : i32
    %42 = llvm.insertelement %37, %40[%41 : i32] : vector<8xi32>
    %43 = llvm.mlir.constant(2 : i32) : i32
    %44 = llvm.insertelement %37, %42[%43 : i32] : vector<8xi32>
    %45 = llvm.mlir.constant(3 : i32) : i32
    %46 = llvm.insertelement %37, %44[%45 : i32] : vector<8xi32>
    %47 = llvm.mlir.constant(4 : i32) : i32
    %48 = llvm.insertelement %37, %46[%47 : i32] : vector<8xi32>
    %49 = llvm.mlir.constant(5 : i32) : i32
    %50 = llvm.insertelement %37, %48[%49 : i32] : vector<8xi32>
    %51 = llvm.mlir.constant(6 : i32) : i32
    %52 = llvm.insertelement %1, %50[%51 : i32] : vector<8xi32>
    %53 = llvm.mlir.constant(7 : i32) : i32
    %54 = llvm.insertelement %37, %52[%53 : i32] : vector<8xi32>
    %55 = llvm.add %arg1, %18  : vector<8xi32>
    %56 = llvm.shl %36, %55  : vector<8xi32>
    %57 = llvm.add %56, %18  : vector<8xi32>
    %58 = llvm.and %57, %arg0  : vector<8xi32>
    %59 = llvm.sub %54, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%55) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%56) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%57) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%59) : (vector<8xi32>) -> ()
    %60 = llvm.shl %58, %59  : vector<8xi32>
    llvm.return %60 : vector<8xi32>
  }
  llvm.func @t2_vec_nonsplat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-33, -32, -31, -1, 0, 1, 31, 32]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %4 = llvm.add %arg1, %0  : vector<8xi32>
    %5 = llvm.shl %1, %4  : vector<8xi32>
    %6 = llvm.add %5, %2  : vector<8xi32>
    %7 = llvm.and %6, %arg0  : vector<8xi32>
    %8 = llvm.sub %3, %arg1  : vector<8xi32>
    llvm.call @use8xi32(%4) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%5) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%6) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%8) : (vector<8xi32>) -> ()
    %9 = llvm.shl %7, %8  : vector<8xi32>
    llvm.return %9 : vector<8xi32>
  }
  llvm.func @n3_extrause(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.shl %1, %3  : i32
    %5 = llvm.add %4, %0  : i32
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
}
