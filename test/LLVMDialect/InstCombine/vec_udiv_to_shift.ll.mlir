module  {
  llvm.func @udiv_vec8x16(%arg0: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<32> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.udiv %arg0, %0  : vector<8xi16>
    llvm.return %1 : vector<8xi16>
  }
  llvm.func @udiv_vec4x32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
}
