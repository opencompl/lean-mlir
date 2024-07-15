module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @p0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @pb(%arg0: i65) -> i1 {
    %0 = llvm.mlir.constant(1 : i65) : i65
    %1 = llvm.shl %arg0, %0  : i65
    %2 = llvm.ashr %1, %0  : i65
    %3 = llvm.icmp "eq" %arg0, %2 : i65
    llvm.return %3 : i1
  }
  llvm.func @p1_vec_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %0  : vector<2xi8>
    %2 = llvm.ashr %1, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @p2_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %0  : vector<2xi8>
    %2 = llvm.ashr %1, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @p3_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<5> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.shl %arg0, %8  : vector<3xi8>
    %11 = llvm.ashr %10, %9  : vector<3xi8>
    %12 = llvm.icmp "eq" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }
  llvm.func @p4_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.shl %arg0, %0  : vector<3xi8>
    %11 = llvm.ashr %10, %9  : vector<3xi8>
    %12 = llvm.icmp "eq" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }
  llvm.func @p5_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.shl %arg0, %8  : vector<3xi8>
    %10 = llvm.ashr %9, %8  : vector<3xi8>
    %11 = llvm.icmp "eq" %10, %arg0 : vector<3xi8>
    llvm.return %11 : vector<3xi1>
  }
  llvm.func @gen8() -> i8
  llvm.func @c0() -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.shl %1, %0  : i8
    %3 = llvm.ashr %2, %0  : i8
    %4 = llvm.icmp "eq" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @use8(i8)
  llvm.func @n_oneuse0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @n_oneuse1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @n_oneuse2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @n0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    %4 = llvm.icmp "eq" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.lshr %1, %0  : i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.icmp "eq" %2, %arg1 : i8
    llvm.return %3 : i1
  }
  llvm.func @n3_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 3]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.ashr %2, %1  : vector<2xi8>
    %4 = llvm.icmp "eq" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
}
