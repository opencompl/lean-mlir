module  {
  llvm.func @use(i32)
  llvm.func @testAdd(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    %1 = llvm.bitcast %0 : i32 to i32
    llvm.return %1 : i32
  }
  llvm.func @and_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @and_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.and %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @and_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %2 = llvm.and %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @and_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @and_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @or_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    %1 = llvm.or %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @or_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.or %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @or_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %2 = llvm.or %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @or_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.or %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @or_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @xor_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    %1 = llvm.xor %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @xor_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.xor %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @xor_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %2 = llvm.xor %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @xor_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.xor %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @xor_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }
}
