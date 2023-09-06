module  {
  llvm.func @foo1(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i32 : (i32) -> !llvm.ptr<i32>
    %3 = llvm.alloca %1 x i32 : (i32) -> !llvm.ptr<i32>
    llvm.store %arg0, %2 : !llvm.ptr<i32>
    %4 = llvm.load %2 : !llvm.ptr<i32>
    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.mul %5, %0  : i32
    llvm.store %6, %3 : !llvm.ptr<i32>
    %7 = llvm.load %3 : !llvm.ptr<i32>
    %8 = llvm.trunc %7 : i32 to i16
    llvm.return %8 : i16
  }
  llvm.func @foo2(%arg0: i32, %arg1: i32) -> i16 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i32 : (i32) -> !llvm.ptr<i32>
    %3 = llvm.alloca %1 x i32 : (i32) -> !llvm.ptr<i32>
    %4 = llvm.alloca %1 x i32 : (i32) -> !llvm.ptr<i32>
    llvm.store %arg0, %2 : !llvm.ptr<i32>
    llvm.store %arg1, %3 : !llvm.ptr<i32>
    %5 = llvm.load %3 : !llvm.ptr<i32>
    %6 = llvm.load %2 : !llvm.ptr<i32>
    %7 = llvm.sub %5, %6  : i32
    %8 = llvm.mul %7, %0  : i32
    llvm.store %8, %4 : !llvm.ptr<i32>
    %9 = llvm.load %4 : !llvm.ptr<i32>
    %10 = llvm.trunc %9 : i32 to i16
    llvm.return %10 : i16
  }
  llvm.func @foo3(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i32 : (i32) -> !llvm.ptr<i32>
    %4 = llvm.alloca %2 x i32 : (i32) -> !llvm.ptr<i32>
    llvm.store %arg0, %3 : !llvm.ptr<i32>
    %5 = llvm.load %3 : !llvm.ptr<i32>
    %6 = llvm.sub %1, %5  : i32
    %7 = llvm.mul %6, %0  : i32
    llvm.store %7, %4 : !llvm.ptr<i32>
    %8 = llvm.load %4 : !llvm.ptr<i32>
    %9 = llvm.trunc %8 : i32 to i16
    llvm.return %9 : i16
  }
}
