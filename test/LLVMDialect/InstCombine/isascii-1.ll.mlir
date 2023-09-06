module  {
  llvm.func @isascii(i32) -> i32
  llvm.func @test_simplify1() -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.call @isascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify2() -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.call @isascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify3(%arg0: i32) -> i32 {
    %0 = llvm.call @isascii(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
}
