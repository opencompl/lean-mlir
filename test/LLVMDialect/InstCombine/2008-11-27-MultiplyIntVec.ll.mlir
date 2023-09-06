module  {
  llvm.func @f(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mul %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @g(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mul %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
}
