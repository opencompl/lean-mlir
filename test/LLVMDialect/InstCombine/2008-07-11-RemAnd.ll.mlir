module  {
  llvm.func @a(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.srem %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @a_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.srem %arg0, %1  : vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
}
