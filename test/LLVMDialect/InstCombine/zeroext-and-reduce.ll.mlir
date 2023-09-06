module  {
  llvm.func @test1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(65544 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
}
