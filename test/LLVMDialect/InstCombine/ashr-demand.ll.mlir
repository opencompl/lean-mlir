module  {
  llvm.func @srem2_ashr_mask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.srem %arg0, %1  : i32
    %3 = llvm.ashr %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @srem8_ashr_mask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.srem %arg0, %2  : i32
    %4 = llvm.ashr %3, %1  : i32
    %5 = llvm.and %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @srem2_ashr_mask_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.srem %arg0, %1  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @srem2_ashr_mask_vector_nonconstant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.srem %arg0, %0  : vector<2xi32>
    %2 = llvm.ashr %1, %arg1  : vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
}
