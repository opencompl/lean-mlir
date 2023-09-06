module  {
  llvm.func @foo(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[2, -2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.srem %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
}
