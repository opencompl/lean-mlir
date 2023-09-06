module  {
  llvm.func @test(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fadd %arg0, %arg1  : vector<4xf32>
    %1 = llvm.fsub %0, %arg1  : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }
}
