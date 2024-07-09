module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0_lshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @t1_sshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.ashr %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @t2_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %0, %arg1  : vector<4xi32>
    %2 = llvm.and %1, %arg0  : vector<4xi32>
    %3 = llvm.lshr %2, %arg1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @t3_vec_undef(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.shl %10, %arg1  : vector<4xi32>
    %12 = llvm.and %11, %arg0  : vector<4xi32>
    %13 = llvm.lshr %12, %arg1  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }
  llvm.func @use32(i32)
  llvm.func @t4_extrause0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @t5_extrause1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @t6_extrause2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @t7_noncanonical_lshr_lshr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @t8_noncanonical_lshr_ashr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.ashr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @t9_noncanonical_ashr_lshr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @t10_noncanonical_ashr_ashr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.ashr %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @gen32() -> i32
  llvm.func @t11_commutative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.lshr %3, %arg0  : i32
    llvm.return %4 : i32
  }
  llvm.func @n12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @n13(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg2  : i32
    llvm.return %3 : i32
  }
  llvm.func @n14(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg3  : i32
    llvm.return %2 : i32
  }
}
