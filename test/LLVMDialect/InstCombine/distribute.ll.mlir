module  {
  llvm.func @factorize(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @factorize2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mul %1, %arg0  : i32
    %3 = llvm.mul %0, %arg0  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @factorize3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.or %arg0, %arg2  : i32
    %3 = llvm.and %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @factorize4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg1, %0  : i32
    %2 = llvm.mul %1, %arg0  : i32
    %3 = llvm.mul %arg0, %arg1  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @factorize5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mul %arg1, %0  : i32
    %2 = llvm.mul %1, %arg0  : i32
    %3 = llvm.mul %arg0, %arg1  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @expand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.or %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
}
