module  {
  llvm.mlir.global external constant @silly() : i32
  llvm.func @bzero(!llvm.ptr<i8>, i32)
  llvm.func @bcopy(!llvm.ptr<i8>, !llvm.ptr<i8>, i32)
  llvm.func @bcmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
  llvm.func @fputs(!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
  llvm.func @fputs_unlocked(!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
  llvm.func @function(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @silly : !llvm.ptr<i32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i32 : (i32) -> !llvm.ptr<i32>
    %3 = llvm.alloca %1 x i32 : (i32) -> !llvm.ptr<i32>
    llvm.store %arg0, %2 : !llvm.ptr<i32>
    %4 = llvm.load %2 : !llvm.ptr<i32>
    %5 = llvm.load %0 : !llvm.ptr<i32>
    %6 = llvm.add %4, %5  : i32
    llvm.store %6, %3 : !llvm.ptr<i32>
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %7 = llvm.load %3 : !llvm.ptr<i32>
    llvm.return %7 : i32
  }
}
