module  {
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.and %4, %1  : i32
    llvm.return %5 : i32
  }
  llvm.func @test2(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg1, %0  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg1, %1  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @or_test2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.shl %arg0, %1  : i8
    %3 = llvm.or %2, %0  : i8
    llvm.return %3 : i8
  }
}
