module  {
  llvm.func @test1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.zext %arg0 : i8 to i64
    %1 = llvm.zext %arg1 : i8 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i8
    llvm.return %3 : i8
  }
  llvm.func @test2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.zext %arg0 : i16 to i64
    %1 = llvm.zext %arg1 : i16 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i16
    llvm.return %3 : i16
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.return %3 : i32
  }
  llvm.func @test4(%arg0: i9, %arg1: i9) -> i9 {
    %0 = llvm.zext %arg0 : i9 to i64
    %1 = llvm.zext %arg1 : i9 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i9
    llvm.return %3 : i9
  }
}
