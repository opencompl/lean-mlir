module  {
  llvm.mlir.global private constant @".str"("%s\00")
  llvm.func @CopyEventArg(%arg0: !llvm.ptr<struct<"union.anon", (i32, array<4 x i8>)>>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr<array<3 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @sprintf(%arg1, %2, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<struct<"union.anon", (i32, array<4 x i8>)>>) -> i32
    llvm.return
  }
  llvm.func @sprintf(!llvm.ptr<i8>, !llvm.ptr<i8>, ...) -> i32
}
