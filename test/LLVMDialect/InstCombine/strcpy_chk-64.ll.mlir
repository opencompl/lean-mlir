module  {
  llvm.func @func(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x !llvm.array<32 x i8> : (i32) -> !llvm.ptr<array<32 x i8>>
    %4 = llvm.getelementptr %3[%1, %1] : (!llvm.ptr<array<32 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @__strcpy_chk(%4, %arg0, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @func2(%4) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @func_no_null_opt(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x !llvm.array<32 x i8> : (i32) -> !llvm.ptr<array<32 x i8>>
    %4 = llvm.getelementptr %3[%1, %1] : (!llvm.ptr<array<32 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @__strcpy_chk(%4, %arg0, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @func2(%4) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @__strcpy_chk(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @func2(!llvm.ptr<i8>)
}
