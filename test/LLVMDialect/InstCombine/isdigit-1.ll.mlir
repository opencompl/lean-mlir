module  {
  llvm.func @isdigit(i32) -> i32
  llvm.func @test_simplify1() -> i32 {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.call @isdigit(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify2() -> i32 {
    %0 = llvm.mlir.constant(48 : i32) : i32
    %1 = llvm.call @isdigit(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify3() -> i32 {
    %0 = llvm.mlir.constant(57 : i32) : i32
    %1 = llvm.call @isdigit(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(58 : i32) : i32
    %1 = llvm.call @isdigit(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify5(%arg0: i32) -> i32 {
    %0 = llvm.call @isdigit(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
}
