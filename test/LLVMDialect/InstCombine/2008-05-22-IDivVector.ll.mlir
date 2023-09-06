module  {
  llvm.func @f(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.sdiv %arg0, %arg0  : vector<3xi8>
    llvm.return %0 : vector<3xi8>
  }
}
