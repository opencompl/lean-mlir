module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "ult" %1, %arg1 : i8
    llvm.return %2 : i1
  }
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.udiv %0, %arg0  : vector<2xi8>
    %2 = llvm.icmp "ult" %1, %arg1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @t2_vec_poison(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.udiv %8, %arg0  : vector<3xi8>
    %10 = llvm.icmp "ult" %9, %arg1 : vector<3xi8>
    llvm.return %10 : vector<3xi1>
  }
  llvm.func @gen8() -> i8
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @use8(i8)
  llvm.func @n4_extrause(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ult" %1, %arg1 : i8
    llvm.return %2 : i1
  }
  llvm.func @n5_not_negone(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "ult" %1, %arg1 : i8
    llvm.return %2 : i1
  }
  llvm.func @n6_wrong_pred0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "ule" %1, %arg1 : i8
    llvm.return %2 : i1
  }
  llvm.func @n6_wrong_pred1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "ugt" %1, %arg1 : i8
    llvm.return %2 : i1
  }
}
