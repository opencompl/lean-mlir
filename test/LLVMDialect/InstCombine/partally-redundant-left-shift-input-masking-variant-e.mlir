module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @use8xi32(vector<8xi32>)
  llvm.func @t1_vec_splat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %arg1  : vector<8xi32>
    %2 = llvm.lshr %1, %arg1  : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    llvm.call @use8xi32(%1) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    %4 = llvm.shl %2, %3  : vector<8xi32>
    llvm.return %4 : vector<8xi32>
  }
  llvm.func @t1_vec_splat_undef(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
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
    %19 = llvm.shl %arg0, %arg1  : vector<8xi32>
    %20 = llvm.lshr %19, %arg1  : vector<8xi32>
    %21 = llvm.add %arg1, %18  : vector<8xi32>
    llvm.call @use8xi32(%19) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%21) : (vector<8xi32>) -> ()
    %22 = llvm.shl %20, %21  : vector<8xi32>
    llvm.return %22 : vector<8xi32>
  }
  llvm.func @t1_vec_nonsplat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-32, -31, -1, 0, 1, 31, 32, 33]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %arg1  : vector<8xi32>
    %2 = llvm.lshr %1, %arg1  : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    llvm.call @use8xi32(%1) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    %4 = llvm.shl %2, %3  : vector<8xi32>
    llvm.return %4 : vector<8xi32>
  }
  llvm.func @n3_extrause(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %2, %3  : i32
    llvm.return %4 : i32
  }
}
