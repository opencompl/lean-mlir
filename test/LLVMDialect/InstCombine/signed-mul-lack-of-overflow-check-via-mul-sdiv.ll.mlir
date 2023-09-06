module  {
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mul %arg0, %arg1  : vector<2xi8>
    %1 = llvm.sdiv %0, %arg0  : vector<2xi8>
    %2 = llvm.icmp "eq" %1, %arg1 : vector<2xi8>
    llvm.return %2 : i1
  }
  llvm.func @gen8() -> i8
  llvm.func @t2_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.mul %0, %arg0  : i8
    %2 = llvm.sdiv %1, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %0 : i8
    llvm.return %3 : i1
  }
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.mul %0, %arg0  : i8
    %2 = llvm.sdiv %1, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %0 : i8
    llvm.return %3 : i1
  }
  llvm.func @t4_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.mul %0, %arg0  : i8
    %2 = llvm.sdiv %1, %arg0  : i8
    %3 = llvm.icmp "eq" %0, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @use8(i8)
  llvm.func @t5_extrause0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }
  llvm.func @t6_extrause1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }
  llvm.func @t7_extrause2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sdiv %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }
  llvm.func @n8_different_x(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg2  : i8
    %1 = llvm.sdiv %0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %arg2 : i8
    llvm.return %2 : i1
  }
  llvm.func @n9_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %arg2 : i8
    llvm.return %2 : i1
  }
  llvm.func @n10_wrong_pred(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.icmp "ult" %1, %arg1 : i8
    llvm.return %2 : i1
  }
}
