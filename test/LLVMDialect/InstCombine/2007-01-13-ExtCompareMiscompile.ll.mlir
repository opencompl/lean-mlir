module  {
  llvm.func @test(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }
}
