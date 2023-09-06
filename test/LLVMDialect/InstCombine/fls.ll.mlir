module  {
  llvm.func @myfls() -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.call @fls(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @myflsl() -> i32 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.call @flsl(%0) : (i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @myflsll() -> i32 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.call @flsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @flsnotconst(%arg0: i64) -> i32 {
    %0 = llvm.call @flsl(%arg0) : (i64) -> i32
    llvm.return %0 : i32
  }
  llvm.func @flszero() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @fls(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @fls(i32) -> i32
  llvm.func @flsl(i64) -> i32
  llvm.func @flsll(i64) -> i32
}
