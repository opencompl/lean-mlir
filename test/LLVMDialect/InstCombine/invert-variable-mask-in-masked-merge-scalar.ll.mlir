module  {
  llvm.func @scalar(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.return %4 : i4
  }
  llvm.func @in_constant_varx_mone_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg1, %0  : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %0  : i4
    llvm.return %4 : i4
  }
  llvm.func @in_constant_varx_6_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.xor %arg1, %1  : i4
    %3 = llvm.xor %arg0, %0  : i4
    %4 = llvm.and %3, %2  : i4
    %5 = llvm.xor %4, %0  : i4
    llvm.return %5 : i4
  }
  llvm.func @in_constant_mone_vary_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg1, %0  : i4
    %2 = llvm.xor %0, %arg0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @in_constant_6_vary_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.xor %arg1, %1  : i4
    %3 = llvm.xor %arg0, %0  : i4
    %4 = llvm.and %3, %2  : i4
    %5 = llvm.xor %4, %arg0  : i4
    llvm.return %5 : i4
  }
  llvm.func @gen4() -> i4
  llvm.func @c_1_0_0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg1, %arg0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.return %4 : i4
  }
  llvm.func @c_0_1_0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @c_0_0_1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.call @gen4() : () -> i4
    %4 = llvm.xor %2, %3  : i4
    %5 = llvm.and %4, %1  : i4
    %6 = llvm.xor %3, %5  : i4
    llvm.return %6 : i4
  }
  llvm.func @c_1_1_0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg1, %arg0  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }
  llvm.func @c_1_0_1(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg1, %0  : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.xor %2, %arg0  : i4
    %4 = llvm.and %3, %1  : i4
    %5 = llvm.xor %2, %4  : i4
    llvm.return %5 : i4
  }
  llvm.func @c_0_1_1(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg1, %0  : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.xor %2, %arg0  : i4
    %4 = llvm.and %3, %1  : i4
    %5 = llvm.xor %2, %4  : i4
    llvm.return %5 : i4
  }
  llvm.func @c_1_1_1(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.call @gen4() : () -> i4
    %3 = llvm.call @gen4() : () -> i4
    %4 = llvm.xor %3, %2  : i4
    %5 = llvm.and %4, %1  : i4
    %6 = llvm.xor %2, %5  : i4
    llvm.return %6 : i4
  }
  llvm.func @commutativity_constant_varx_6_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.xor %arg1, %1  : i4
    %3 = llvm.xor %arg0, %0  : i4
    %4 = llvm.and %2, %3  : i4
    %5 = llvm.xor %4, %0  : i4
    llvm.return %5 : i4
  }
  llvm.func @commutativity_constant_6_vary_invmask(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.xor %arg1, %1  : i4
    %3 = llvm.xor %arg0, %0  : i4
    %4 = llvm.and %2, %3  : i4
    %5 = llvm.xor %4, %arg0  : i4
    llvm.return %5 : i4
  }
  llvm.func @use4(i4)
  llvm.func @n_oneuse_D_is_ok(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.call @use4(%2) : (i4) -> ()
    llvm.return %4 : i4
  }
  llvm.func @n_oneuse_A(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.call @use4(%3) : (i4) -> ()
    llvm.return %4 : i4
  }
  llvm.func @n_oneuse_AD(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.call @use4(%2) : (i4) -> ()
    llvm.call @use4(%3) : (i4) -> ()
    llvm.return %4 : i4
  }
  llvm.func @n_third_var(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg3, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg2  : i4
    llvm.return %4 : i4
  }
  llvm.func @n_badxor(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.xor %arg2, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.and %2, %1  : i4
    %4 = llvm.xor %3, %arg1  : i4
    llvm.return %4 : i4
  }
}
