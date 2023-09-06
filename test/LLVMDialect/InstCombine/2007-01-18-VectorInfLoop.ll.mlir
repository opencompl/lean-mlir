module  {
  llvm.func @test(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.xor %arg0, %0  : vector<4xi32>
    %2 = llvm.and %1, %0  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
}
