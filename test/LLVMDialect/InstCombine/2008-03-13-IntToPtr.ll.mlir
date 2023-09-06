module  {
  llvm.func @bork(%arg0: !llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<ptr<i8>>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i8> to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.inttoptr %3 : i32 to !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
}
