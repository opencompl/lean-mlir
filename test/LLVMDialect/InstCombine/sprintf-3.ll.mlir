module  {
  llvm.mlir.global external constant @percent_s("%s\00")
  llvm.func @sprintf(!llvm.ptr<ptr<i8>>, !llvm.ptr<i32>, ...) -> i32
  llvm.func @PR51200(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i32>) -> i32 {
    %0 = llvm.mlir.addressof @percent_s : !llvm.ptr<array<3 x i8>>
    %1 = llvm.bitcast %0 : !llvm.ptr<array<3 x i8>> to !llvm.ptr<i32>
    %2 = llvm.call @sprintf(%arg0, %1, %arg1) : (!llvm.ptr<ptr<i8>>, !llvm.ptr<i32>, !llvm.ptr<i32>) -> i32
    llvm.return %2 : i32
  }
}
