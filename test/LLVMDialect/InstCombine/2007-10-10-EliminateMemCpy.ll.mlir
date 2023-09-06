module  {
  llvm.mlir.global internal constant @".str"("xyz\00")
  llvm.func @foo(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @".str" : !llvm.ptr<array<4 x i8>>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.alloca %4 x !llvm.ptr<i8> : (i32) -> !llvm.ptr<ptr<i8>>
    llvm.store %arg0, %5 : !llvm.ptr<ptr<i8>>
    %6 = llvm.load %5 : !llvm.ptr<ptr<i8>>
    %7 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%6, %7, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @llvm.memcpy.p0i8.p0i8.i32(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1)
}
