module  {
  llvm.func @test(%arg0: !llvm.ptr<struct<"struct.Moves", (array<9 x i8>, i8, i8, i8, array<5 x i8>)>, 1>) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(9 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.getelementptr %arg0[%5, %4, %3] : (!llvm.ptr<struct<"struct.Moves", (array<9 x i8>, i8, i8, i8, array<5 x i8>)>, 1>, i32, i32, i32) -> !llvm.ptr<i8, 1>
    llvm.call @llvm.memset.p1i8.i64(%6, %2, %1, %0) : (!llvm.ptr<i8, 1>, i8, i64, i1) -> ()
    llvm.return %4 : i32
  }
  llvm.func @llvm.memset.p1i8.i64(!llvm.ptr<i8, 1>, i8, i64, i1)
}
