module  {
  llvm.func @a() {
    %0 = llvm.mlir.null : !llvm.ptr<i32, 1>
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %1, %0 : !llvm.ptr<i32, 1>
    llvm.return
  }
}
