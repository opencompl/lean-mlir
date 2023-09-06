module  {
  llvm.func @test2(%arg0: i32) {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-12 : i32) : i32
    %3 = llvm.add %arg0, %2  : i32
    %4 = llvm.inttoptr %3 : i32 to !llvm.ptr<i32>
    llvm.store %1, %4 : !llvm.ptr<i32>
    %5 = llvm.add %arg0, %0  : i32
    %6 = llvm.inttoptr %5 : i32 to !llvm.ptr<i32>
    %7 = llvm.getelementptr %6[%1] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %8 = llvm.load %7 : !llvm.ptr<i32>
    %9 = llvm.call @callee(%8) : (i32) -> i32
    llvm.return
  }
  llvm.func @callee(i32) -> i32
}
