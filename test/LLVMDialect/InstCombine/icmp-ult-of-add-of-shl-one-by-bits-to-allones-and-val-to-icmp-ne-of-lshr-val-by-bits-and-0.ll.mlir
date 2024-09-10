module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use8(i8)
  llvm.func @use2i8(vector<2xi8>)
  llvm.func @use3i8(vector<3xi8>)
  llvm.func @p0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @p1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1  : vector<2xi8>
    llvm.call @use2i8(%2) : (vector<2xi8>) -> ()
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @p2_vec_undef0(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.shl %8, %arg1  : vector<3xi8>
    llvm.call @use3i8(%10) : (vector<3xi8>) -> ()
    %11 = llvm.add %10, %9  : vector<3xi8>
    %12 = llvm.icmp "ult" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }
  llvm.func @p2_vec_poison0(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.shl %8, %arg1  : vector<3xi8>
    llvm.call @use3i8(%10) : (vector<3xi8>) -> ()
    %11 = llvm.add %10, %9  : vector<3xi8>
    %12 = llvm.icmp "ult" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }
  llvm.func @p2_vec_poison1(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.shl %0, %arg1  : vector<3xi8>
    llvm.call @use3i8(%10) : (vector<3xi8>) -> ()
    %11 = llvm.add %10, %9  : vector<3xi8>
    %12 = llvm.icmp "ult" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }
  llvm.func @p2_vec_poison2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(-1 : i8) : i8
    %10 = llvm.mlir.undef : vector<3xi8>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi8>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi8>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi8>
    %17 = llvm.shl %8, %arg1  : vector<3xi8>
    llvm.call @use3i8(%17) : (vector<3xi8>) -> ()
    %18 = llvm.add %17, %16  : vector<3xi8>
    %19 = llvm.icmp "ult" %18, %arg0 : vector<3xi8>
    llvm.return %19 : vector<3xi1>
  }
  llvm.func @gen8() -> i8
  llvm.func @c0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.call @gen8() : () -> i8
    %5 = llvm.icmp "ugt" %4, %3 : i8
    llvm.return %5 : i1
  }
  llvm.func @both(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.add %4, %1  : i8
    %6 = llvm.icmp "ult" %3, %5 : i8
    llvm.return %6 : i1
  }
  llvm.func @oneuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @n0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @n2_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1  : vector<2xi8>
    llvm.call @use2i8(%2) : (vector<2xi8>) -> ()
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @n3_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1  : vector<2xi8>
    llvm.call @use2i8(%2) : (vector<2xi8>) -> ()
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @n3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.icmp "ule" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @n4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.call @gen8() : () -> i8
    %5 = llvm.icmp "uge" %4, %3 : i8
    llvm.return %5 : i1
  }
}
