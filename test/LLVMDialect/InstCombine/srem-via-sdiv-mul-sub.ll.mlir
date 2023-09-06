module  {
  llvm.func @use8(i8)
  llvm.func @use2xi8(vector<2xi8>)
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg1  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t1_vector(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.sdiv %arg0, %arg1  : vector<2xi8>
    llvm.call @use2xi8(%0) : (vector<2xi8>) -> ()
    %1 = llvm.mul %0, %arg1  : vector<2xi8>
    %2 = llvm.sub %arg0, %1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @t4_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @gen8() -> i8
  llvm.func @t5_commutative(%arg0: i8) -> i8 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.mul %0, %1  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @n6_different_x(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg2  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg2  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @n6_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg2  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
}
