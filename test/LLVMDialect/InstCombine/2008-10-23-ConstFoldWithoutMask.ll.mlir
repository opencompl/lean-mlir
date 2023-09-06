module  {
  llvm.func @tstid() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr<i8>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i8> to i32
    llvm.return %2 : i32
  }
}
