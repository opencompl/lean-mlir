module  {
  llvm.func @t(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : vector<4xi8>
    %1 = llvm.sext %0 : i1 to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }
}
