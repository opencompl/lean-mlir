module  {
  llvm.func @llvm.lifetime.start.p0i8(i64, !llvm.ptr<i8>)
  llvm.func @llvm.lifetime.end.p0i8(i64, !llvm.ptr<i8>)
  llvm.func @foo(!llvm.ptr<i8>)
  llvm.func @asan() {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i8 : (i32) -> !llvm.ptr<i8>
    llvm.call @llvm.lifetime.start.p0i8(%0, %2) : (i64, !llvm.ptr<i8>) -> ()
    llvm.call @llvm.lifetime.end.p0i8(%0, %2) : (i64, !llvm.ptr<i8>) -> ()
    llvm.call @foo(%2) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @hwasan() {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i8 : (i32) -> !llvm.ptr<i8>
    llvm.call @llvm.lifetime.start.p0i8(%0, %2) : (i64, !llvm.ptr<i8>) -> ()
    llvm.call @llvm.lifetime.end.p0i8(%0, %2) : (i64, !llvm.ptr<i8>) -> ()
    llvm.call @foo(%2) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @msan() {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i8 : (i32) -> !llvm.ptr<i8>
    llvm.call @llvm.lifetime.start.p0i8(%0, %2) : (i64, !llvm.ptr<i8>) -> ()
    llvm.call @llvm.lifetime.end.p0i8(%0, %2) : (i64, !llvm.ptr<i8>) -> ()
    llvm.call @foo(%2) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @no_asan() {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i8 : (i32) -> !llvm.ptr<i8>
    llvm.call @llvm.lifetime.start.p0i8(%0, %2) : (i64, !llvm.ptr<i8>) -> ()
    llvm.call @llvm.lifetime.end.p0i8(%0, %2) : (i64, !llvm.ptr<i8>) -> ()
    llvm.call @foo(%2) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
}
