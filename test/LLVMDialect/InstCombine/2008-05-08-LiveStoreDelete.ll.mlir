module  {
  llvm.func @a() -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.bitcast %4 : i32 to i32
    %6 = llvm.call @malloc(%3) : (i32) -> !llvm.ptr<i8>
    %7 = llvm.getelementptr %6[%2] : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.store %1, %7 : !llvm.ptr<i8>
    %8 = llvm.getelementptr %6[%4] : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.store %0, %8 : !llvm.ptr<i8>
    %9 = llvm.call @strlen(%6) : (!llvm.ptr<i8>) -> i32
    %10 = llvm.getelementptr %6[%4] : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.store %1, %10 : !llvm.ptr<i8>
    %11 = llvm.call @b(%6) : (!llvm.ptr<i8>) -> i32
    llvm.return %9 : i32
  }
  llvm.func @malloc(i32) -> !llvm.ptr<i8>
  llvm.func @strlen(!llvm.ptr<i8>) -> i32
  llvm.func @b(...) -> i32
}
