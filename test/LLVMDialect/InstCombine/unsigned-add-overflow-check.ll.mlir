module  {
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ult" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.add %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "ult" %0, %arg1 : vector<2xi8>
    llvm.return %1 : i1
  }
  llvm.func @t2_symmetry(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @gen8() -> i8
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @t4_commutative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ugt" %arg1, %0 : i8
    llvm.return %1 : i1
  }
  llvm.func @t5_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.icmp "ugt" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @use8(i8)
  llvm.func @t6_extrause(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ult" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @n7_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ult" %0, %arg2 : i8
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
}
