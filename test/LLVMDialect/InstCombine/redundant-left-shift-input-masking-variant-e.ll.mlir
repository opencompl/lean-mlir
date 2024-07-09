module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @t1_bigger_shift(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @use3xi32(vector<3xi32>)
  llvm.func @t2_vec_splat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.shl %arg0, %arg1  : vector<3xi32>
    %2 = llvm.lshr %1, %arg1  : vector<3xi32>
    %3 = llvm.add %arg1, %0  : vector<3xi32>
    llvm.call @use3xi32(%1) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%2) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    %4 = llvm.shl %2, %3  : vector<3xi32>
    llvm.return %4 : vector<3xi32>
  }
  llvm.func @t3_vec_nonsplat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[1, 0, 2]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.shl %arg0, %arg1  : vector<3xi32>
    %2 = llvm.lshr %1, %arg1  : vector<3xi32>
    %3 = llvm.add %arg1, %0  : vector<3xi32>
    llvm.call @use3xi32(%1) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%2) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    %4 = llvm.shl %2, %3  : vector<3xi32>
    llvm.return %4 : vector<3xi32>
  }
  llvm.func @t4_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.shl %arg0, %arg1  : vector<3xi32>
    %10 = llvm.lshr %9, %arg1  : vector<3xi32>
    %11 = llvm.add %arg1, %8  : vector<3xi32>
    llvm.call @use3xi32(%9) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%10) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%11) : (vector<3xi32>) -> ()
    %12 = llvm.shl %10, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }
  llvm.func @t5_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @t6_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @t7_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg1 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @t8_assume_uge(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "uge" %arg2, %arg1 : i32
    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %arg2  : i32
    llvm.return %3 : i32
  }
  llvm.func @n9_different_shamts0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @n10_different_shamts1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg2  : i32
    llvm.return %2 : i32
  }
}
