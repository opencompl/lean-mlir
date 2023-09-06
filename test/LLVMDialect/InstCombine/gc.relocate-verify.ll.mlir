module  {
  llvm.func @check_verify_undef_token() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.metadata
    %2 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %2 : i32
  ^bb1:  // no predecessors
    %3 = llvm.call @llvm.experimental.gc.relocate.p1i32(%1, %2, %2) : (!llvm.metadata, i32, i32) -> !llvm.ptr<i32, 1>
    llvm.return %0 : i32
  }
  llvm.func @llvm.experimental.gc.relocate.p1i32(!llvm.metadata, i32, i32) -> !llvm.ptr<i32, 1>
}
