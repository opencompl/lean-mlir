module  {
  llvm.func @test(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.sdiv %arg1, %arg2  : i32
    %1 = llvm.add %arg2, %arg1  : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
}
