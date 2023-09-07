import SSA.Projects.InstCombine.Syntax

def add_mask := [mlir_op| 
module  {
  llvm.func @add_mask_sign_i32(%arg0: i32) -> i32 {
    --%0 = llvm.mlir.constant(8 : i32) : i32
    --%1 = llvm.mlir.constant(31 : i32) : i32
    %2 = "llvm.ashr"( %arg0, %1)  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_mask_sign_commute_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_mask_sign_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.add %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @add_mask_sign_v2i32_nonuniform(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8, 16]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[30, 31]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.add %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @add_mask_ashr28_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(28 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_mask_ashr28_non_pow2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(28 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_mask_ashr27_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(27 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }
}
]