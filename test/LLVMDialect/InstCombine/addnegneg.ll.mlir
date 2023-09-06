module  {
  llvm.func @l(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.sub %0, %arg2  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.add %3, %arg3  : i32
    llvm.return %4 : i32
  }
}
