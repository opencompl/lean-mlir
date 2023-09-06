module  {
  llvm.func @scalar0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.return %3 : i4
  }
  llvm.func @scalar1(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.return %3 : i4
  }
  llvm.func @in_constant_varx_mone(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.xor %arg0, %1  : i4
    %3 = llvm.and %2, %0  : i4
    %4 = llvm.xor %3, %1  : i4
    llvm.return %4 : i4
  }
  llvm.func @in_constant_varx_14(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.xor %arg0, %1  : i4
    %3 = llvm.and %2, %0  : i4
    %4 = llvm.xor %3, %1  : i4
    llvm.return %4 : i4
  }
  llvm.func @in_constant_mone_vary(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.xor %arg0, %1  : i4
    %3 = llvm.and %2, %0  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @in_constant_14_vary(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.xor %arg0, %1  : i4
    %3 = llvm.and %2, %0  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @gen4() -> i4
  llvm.func @c_1_0_0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg1, %arg0  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.return %3 : i4
  }
  llvm.func @c_0_1_0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg0  : i4
    llvm.return %3 : i4
  }
  llvm.func @c_0_0_1() -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.call @gen4() : () -> i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.xor %1, %2  : i4
    %4 = llvm.and %3, %0  : i4
    %5 = llvm.xor %2, %4  : i4
    llvm.return %5 : i4
  }
  llvm.func @c_1_1_0(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg1, %arg0  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg0  : i4
    llvm.return %3 : i4
  }
  llvm.func @c_1_0_1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.call @gen4() : () -> i4
    %2 = llvm.xor %1, %arg0  : i4
    %3 = llvm.and %2, %0  : i4
    %4 = llvm.xor %1, %3  : i4
    llvm.return %4 : i4
  }
  llvm.func @c_0_1_1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.call @gen4() : () -> i4
    %2 = llvm.xor %1, %arg0  : i4
    %3 = llvm.and %2, %0  : i4
    %4 = llvm.xor %1, %3  : i4
    llvm.return %4 : i4
  }
  llvm.func @c_1_1_1() -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.call @gen4() : () -> i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.xor %2, %1  : i4
    %4 = llvm.and %3, %0  : i4
    %5 = llvm.xor %1, %4  : i4
    llvm.return %5 : i4
  }
  llvm.func @commutativity_constant_14_vary(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.xor %arg0, %1  : i4
    %3 = llvm.and %2, %0  : i4
    %4 = llvm.xor %arg0, %3  : i4
    llvm.return %4 : i4
  }
  llvm.func @use4(i4)
  llvm.func @n_oneuse_D(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.call @use4(%1) : (i4) -> ()
    llvm.return %3 : i4
  }
  llvm.func @n_oneuse_A(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.call @use4(%2) : (i4) -> ()
    llvm.return %3 : i4
  }
  llvm.func @n_oneuse_AD(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg1  : i4
    llvm.call @use4(%1) : (i4) -> ()
    llvm.call @use4(%2) : (i4) -> ()
    llvm.return %3 : i4
  }
  llvm.func @n_var_mask(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg0, %arg1  : i4
    %1 = llvm.and %0, %arg2  : i4
    %2 = llvm.xor %1, %arg1  : i4
    llvm.return %2 : i4
  }
  llvm.func @n_third_var(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.and %1, %0  : i4
    %3 = llvm.xor %2, %arg2  : i4
    llvm.return %3 : i4
  }
}
