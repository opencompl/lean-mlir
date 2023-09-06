module  {
  llvm.func @g(!llvm.ptr<i8>)
  llvm.func @g_addr1(!llvm.ptr<i8, 1>)
  llvm.func @llvm.invariant.start.p0i8(i64, !llvm.ptr<i8>) -> !llvm.ptr<struct<()>>
  llvm.func @llvm.invariant.start.p1i8(i64, !llvm.ptr<i8, 1>) -> !llvm.ptr<struct<()>>
  llvm.func @f() -> i8 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i8 : (i32) -> !llvm.ptr<i8>
    llvm.store %1, %3 : !llvm.ptr<i8>
    %4 = llvm.call @llvm.invariant.start.p0i8(%0, %3) : (i64, !llvm.ptr<i8>) -> !llvm.ptr<struct<()>>
    llvm.call @g(%3) : (!llvm.ptr<i8>) -> ()
    %5 = llvm.load %3 : !llvm.ptr<i8>
    llvm.return %5 : i8
  }
  llvm.func @f_addrspace1(%arg0: !llvm.ptr<i8, 1>) -> i8 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %1, %arg0 : !llvm.ptr<i8, 1>
    %2 = llvm.call @llvm.invariant.start.p1i8(%0, %arg0) : (i64, !llvm.ptr<i8, 1>) -> !llvm.ptr<struct<()>>
    llvm.call @g_addr1(%arg0) : (!llvm.ptr<i8, 1>) -> ()
    %3 = llvm.load %arg0 : !llvm.ptr<i8, 1>
    llvm.return %3 : i8
  }
}
