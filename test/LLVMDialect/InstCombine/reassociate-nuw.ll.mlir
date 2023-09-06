module  {
  llvm.func @reassoc_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %1  : i32
    %3 = llvm.add %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @reassoc_sub_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.sub %arg0, %1  : i32
    %3 = llvm.sub %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @reassoc_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mul %arg0, %1  : i32
    %3 = llvm.mul %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @no_reassoc_add_nuw_none(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %1  : i32
    %3 = llvm.add %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @no_reassoc_add_none_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %1  : i32
    %3 = llvm.add %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @reassoc_x2_add_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %1  : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @reassoc_x2_mul_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mul %arg0, %1  : i32
    %3 = llvm.mul %arg1, %0  : i32
    %4 = llvm.mul %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @reassoc_x2_sub_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.sub %arg0, %1  : i32
    %3 = llvm.sub %arg1, %0  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.add %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul_nuw_int_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.add %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_mul_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.add %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.add %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul_nuw_mul_nuw_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    %1 = llvm.mul %arg0, %arg2  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul_mul_nuw_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    %1 = llvm.mul %arg0, %arg2  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_nuw_mul_nuw_mul_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    %1 = llvm.mul %arg0, %arg2  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @tryFactorization_add_mul_nuw_mul_var(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    %1 = llvm.mul %arg0, %arg2  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
}
