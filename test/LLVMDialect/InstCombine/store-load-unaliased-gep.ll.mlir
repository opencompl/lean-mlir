module  {
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.alloca %2 x i32 : (i32) -> !llvm.ptr<i32>
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %5 = llvm.getelementptr %3[%0] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %arg0, %4 : !llvm.ptr<i32>
    llvm.store %1, %5 : !llvm.ptr<i32>
    %6 = llvm.load %4 : !llvm.ptr<i32>
    llvm.return %6 : i32
  }
}
