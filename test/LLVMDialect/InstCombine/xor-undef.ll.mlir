module  {
  llvm.func @f() -> vector<2xi64> {
    %0 = llvm.mlir.undef : vector<2xi64>
    %1 = llvm.xor %0, %0  : vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
}
