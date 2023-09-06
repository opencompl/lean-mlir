module  {
  llvm.func @strchr(!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
  llvm.func @pr43081(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x !llvm.ptr<i8> : (i32) -> !llvm.ptr<ptr<i8>>
    llvm.store %arg0, %2 : !llvm.ptr<ptr<i8>>
    %3 = llvm.load %2 : !llvm.ptr<ptr<i8>>
    %4 = llvm.call @strchr(%3, %0) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
}
