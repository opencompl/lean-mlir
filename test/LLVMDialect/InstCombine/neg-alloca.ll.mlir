module  {
  llvm.func @use(!llvm.ptr<i32>)
  llvm.func @foo(%arg0: i64) {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.constant(-4 : i64) : i64
    %2 = llvm.mul %arg0, %1  : i64
    %3 = llvm.add %2, %0  : i64
    %4 = llvm.alloca %3 x i8 : (i64) -> !llvm.ptr<i8>
    %5 = llvm.bitcast %4 : !llvm.ptr<i8> to !llvm.ptr<i32>
    llvm.call @use(%5) : (!llvm.ptr<i32>) -> ()
    llvm.return
  }
}
