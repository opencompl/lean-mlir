module  {
  llvm.func @a(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %1, %arg0  : i32
    %3 = llvm.sdiv %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.call @a(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %2, %1  : i32
    %4 = llvm.sdiv %3, %0  : i32
    llvm.return %4 : i32
  }
}
