module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use8(i8)
  llvm.func @use2x8(vector<2xi8>)
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "uge" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg1, %0  : vector<2xi8>
    llvm.call @use2x8(%1) : (vector<2xi8>) -> ()
    %2 = llvm.icmp "uge" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @gen8() -> i8
  llvm.func @t2_commutative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @t3_no_extrause(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.icmp "uge" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n4_wrong_pred0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n5_wrong_pred1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ugt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n6_wrong_pred2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n7_wrong_pred3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n8_wrong_pred4(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "slt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n9_wrong_pred5(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "sle" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n10_wrong_pred6(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n11_wrong_pred7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "sge" %1, %arg0 : i8
    llvm.return %2 : i1
  }
  llvm.func @n12_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1, -2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg1, %0  : vector<2xi8>
    llvm.call @use2x8(%1) : (vector<2xi8>) -> ()
    %2 = llvm.icmp "uge" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
}
