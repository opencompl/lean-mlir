module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "uge" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.add %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "uge" %0, %arg1 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @t2_symmetry(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "uge" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @gen8() -> i8
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t4_commutative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ule" %arg1, %0 : i8
    llvm.return %1 : i1
  }
  llvm.func @t5_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.icmp "ule" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @use8(i8)
  llvm.func @t6_extrause(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @n7_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "uge" %0, %arg2 : i8
    llvm.return %1 : i1
  }
  llvm.func @n8_wrong_pred0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ule" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @n9_wrong_pred1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ugt" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @n10_wrong_pred2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "eq" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @n11_wrong_pred3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ne" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @n12_wrong_pred4(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "slt" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @n13_wrong_pred5(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "sle" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @n14_wrong_pred6(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "sgt" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @n15_wrong_pred7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "sge" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @low_bitmask_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @low_bitmask_uge(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.add %arg0, %6  : vector<2xi8>
    %9 = llvm.and %8, %7  : vector<2xi8>
    %10 = llvm.icmp "uge" %9, %arg0 : vector<2xi8>
    llvm.return %10 : vector<2xi1>
  }
  llvm.func @low_bitmask_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @low_bitmask_ule(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mul %arg0, %arg0  : vector<2xi8>
    %2 = llvm.add %1, %0  : vector<2xi8>
    %3 = llvm.and %2, %0  : vector<2xi8>
    %4 = llvm.icmp "ule" %1, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @low_bitmask_ult_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @low_bitmask_ugt_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.add %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @low_bitmask_ult_wrong_mask1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(30 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @low_bitmask_uge_wrong_mask2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "uge" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @low_bitmask_ugt_swapped(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ugt" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @low_bitmask_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.icmp "sgt" %1, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @low_bitmask_ult_specific_op(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.return %3 : i1
  }
}
