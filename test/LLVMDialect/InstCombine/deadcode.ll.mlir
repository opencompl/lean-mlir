module  {
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %1, %1  : i1
    llvm.cond_br %2, ^bb1, ^bb2(%arg0 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg0, %0  : i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @test2(%arg0: i32) -> !llvm.ptr<i32> {
    %0 = llvm.call @llvm.stacksave() : () -> !llvm.ptr<i8>
    %1 = llvm.alloca %arg0 x i32 : (i32) -> !llvm.ptr<i32>
    llvm.return %1 : !llvm.ptr<i32>
  }
  llvm.func @llvm.stacksave() -> !llvm.ptr<i8>
  llvm.func @llvm.lifetime.start.p0i8(i64, !llvm.ptr<i8>)
  llvm.func @llvm.lifetime.end.p0i8(i64, !llvm.ptr<i8>)
  llvm.func @test3() {
    %0 = llvm.mlir.undef : !llvm.ptr<i8>
    %1 = llvm.mlir.constant(-1 : i64) : i64
    llvm.call @llvm.lifetime.start.p0i8(%1, %0) : (i64, !llvm.ptr<i8>) -> ()
    llvm.call @llvm.lifetime.end.p0i8(%1, %0) : (i64, !llvm.ptr<i8>) -> ()
    llvm.return
  }
}
