module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @p0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @p1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg1  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    %3 = llvm.and %2, %arg0  : vector<2xi8>
    %4 = llvm.icmp "ne" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @p2_vec_poison0(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
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
    %11 = llvm.xor %10, %9  : vector<3xi8>
    %12 = llvm.and %11, %arg0  : vector<3xi8>
    %13 = llvm.icmp "ne" %12, %arg0 : vector<3xi8>
    llvm.return %13 : vector<3xi1>
  }
  llvm.func @p3_vec_poison0(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
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
    %11 = llvm.xor %10, %9  : vector<3xi8>
    %12 = llvm.and %11, %arg0  : vector<3xi8>
    %13 = llvm.icmp "ne" %12, %arg0 : vector<3xi8>
    llvm.return %13 : vector<3xi1>
  }
  llvm.func @p4_vec_poison2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.shl %8, %arg1  : vector<3xi8>
    %10 = llvm.xor %9, %8  : vector<3xi8>
    %11 = llvm.and %10, %arg0  : vector<3xi8>
    %12 = llvm.icmp "ne" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }
  llvm.func @gen8() -> i8
  llvm.func @c0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.call @gen8() : () -> i8
    %4 = llvm.and %3, %2  : i8
    %5 = llvm.icmp "ne" %4, %3 : i8
    llvm.return %5 : i1
  }
  llvm.func @c1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.call @gen8() : () -> i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "ne" %3, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @c2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.call @gen8() : () -> i8
    %4 = llvm.and %3, %2  : i8
    %5 = llvm.icmp "ne" %3, %4 : i8
    llvm.return %5 : i1
  }
  llvm.func @use8(i8)
  llvm.func @oneuse0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @oneuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @oneuse2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @oneuse3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @oneuse4(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @oneuse5(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @n0(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %arg2 : i8
    llvm.return %4 : i1
  }
  llvm.func @n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "ne" %4, %arg0 : i8
    llvm.return %5 : i1
  }
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "ne" %4, %arg0 : i8
    llvm.return %5 : i1
  }
}
