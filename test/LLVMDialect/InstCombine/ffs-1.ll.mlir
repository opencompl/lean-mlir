module  {
  llvm.func @ffs(i32) -> i32
  llvm.func @ffsl(i32) -> i32
  llvm.func @ffsll(i64) -> i32
  llvm.func @test_simplify1() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @ffs(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify2() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @ffsl(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify3() -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @ffs(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify5() -> i32 {
    %0 = llvm.mlir.constant(2048 : i32) : i32
    %1 = llvm.call @ffs(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify6() -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.call @ffs(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify7() -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.call @ffsl(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify8() -> i32 {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify9() -> i32 {
    %0 = llvm.mlir.constant(65536 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify10() -> i32 {
    %0 = llvm.mlir.constant(17179869184 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify11() -> i32 {
    %0 = llvm.mlir.constant(281474976710656 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify12() -> i32 {
    %0 = llvm.mlir.constant(1152921504606846976 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify13(%arg0: i32) -> i32 {
    %0 = llvm.call @ffs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @test_simplify14(%arg0: i32) -> i32 {
    %0 = llvm.call @ffsl(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @test_simplify15(%arg0: i64) -> i32 {
    %0 = llvm.call @ffsll(%arg0) : (i64) -> i32
    llvm.return %0 : i32
  }
}
