module  {
  llvm.func @test_bigalloc(%arg0: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(-4294967296 : i864) : i864
    %2 = llvm.alloca %1 x i8 : (i864) -> !llvm.ptr<i8>
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr<i8>, i1) -> !llvm.ptr<i8>
    llvm.store %3, %arg0 : !llvm.ptr<ptr<i8>>
    llvm.return
  }
}
