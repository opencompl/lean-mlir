module  {
  llvm.func @test(%arg0: i16, %arg1: i16) -> i64 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.sext %arg1 : i16 to i32
    %2 = llvm.add %0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }
}
