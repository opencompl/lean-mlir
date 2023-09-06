module  {
  llvm.func @foo(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.trunc %arg1 : i64 to i32
    %2 = llvm.and %0, %1  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }
}
