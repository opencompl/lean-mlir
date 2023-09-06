module  {
  llvm.func @"hang_2002-03-11"(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return
  }
  llvm.func @"sub_failure_2002-05-14"(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mul %arg0, %arg1  : i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @"cast_test_2002-08-02"(%arg0: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i8
    %1 = llvm.zext %0 : i8 to i64
    llvm.return %1 : i64
  }
  llvm.func @"missed_const_prop_2002-12-05"(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %1, %arg0  : i32
    %3 = llvm.sub %1, %0  : i32
    %4 = llvm.add %3, %0  : i32
    %5 = llvm.add %arg0, %4  : i32
    %6 = llvm.add %2, %5  : i32
    llvm.return %6 : i32
  }
}
