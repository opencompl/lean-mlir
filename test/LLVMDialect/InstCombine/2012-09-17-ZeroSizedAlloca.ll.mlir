module  {
  llvm.mlir.global external @x() : !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.mlir.global external @y() : !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @f() {
    %0 = llvm.mlir.addressof @y : !llvm.ptr<ptr<i8>>
    %1 = llvm.mlir.addressof @x : !llvm.ptr<ptr<i8>>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.alloca %3 x !llvm.array<0 x i8> : (i32) -> !llvm.ptr<array<0 x i8>>
    %5 = llvm.alloca %3 x !llvm.array<0 x i8> : (i32) -> !llvm.ptr<array<0 x i8>>
    %6 = llvm.getelementptr %4[%2, %2] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %7 = llvm.getelementptr %5[%2, %2] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.store %6, %1 : !llvm.ptr<ptr<i8>>
    llvm.store %7, %0 : !llvm.ptr<ptr<i8>>
    llvm.return
  }
}
