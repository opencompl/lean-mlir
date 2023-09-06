module  {
  llvm.func @calloc(i64, i32) -> !llvm.ptr<i8>
  llvm.func @PR50846() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @calloc(%1, %0) : (i64, i32) -> !llvm.ptr<i8>
    llvm.return
  }
}
