module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use8(i8)
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @t1_otherbitwidth(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    %2 = llvm.ashr %1, %0  : i16
    llvm.return %2 : i16
  }
  llvm.func @t2_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %0  : vector<2xi8>
    %2 = llvm.ashr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @t3_vec_poison0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<7> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.shl %arg0, %8  : vector<3xi8>
    %11 = llvm.ashr %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }
  llvm.func @t4_vec_poison1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.shl %arg0, %0  : vector<3xi8>
    %11 = llvm.ashr %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }
  llvm.func @t5_vec_poison2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.shl %arg0, %8  : vector<3xi8>
    %10 = llvm.ashr %9, %8  : vector<3xi8>
    llvm.return %10 : vector<3xi8>
  }
  llvm.func @n6_extrause(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @t7_already_masked(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.ashr %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @t8_already_masked_extrause(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.ashr %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @n9_wrongly_masked_extrause(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.ashr %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @n10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @n11(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @n12(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    llvm.return %2 : i8
  }
}
