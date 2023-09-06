module  {
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.icmp "ugt" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sub %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "ugt" %0, %arg0 : vector<2xi8>
    llvm.return %1 : i1
  }
  llvm.func @t2_commutative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }
  llvm.func @use8(i8)
  llvm.func @t3_extrause0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ugt" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @n4_not_commutative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.icmp "ugt" %0, %arg1 : i8
    llvm.return %1 : i1
  }
  llvm.func @n5_wrong_pred0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.icmp "uge" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @n6_wrong_pred1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @n7_wrong_pred2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @n8_wrong_pred3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.icmp "ne" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @n9_wrong_pred4(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.icmp "slt" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @n10_wrong_pred5(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.icmp "sle" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @n11_wrong_pred6(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.icmp "sgt" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @n12_wrong_pred7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.icmp "sge" %0, %arg0 : i8
    llvm.return %1 : i1
  }
}
