module  {
  llvm.func @foo(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x !llvm.array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>> : (i32) -> !llvm.ptr<array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>>
    %4 = llvm.getelementptr %3[%1, %1] : (!llvm.ptr<array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>>, i32, i32) -> !llvm.ptr<struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>
    %5 = llvm.getelementptr %4[%1, %1] : (!llvm.ptr<struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>, i32, i32) -> !llvm.ptr<struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>>
    %6 = llvm.getelementptr %5[%1, %1] : (!llvm.ptr<struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>>, i32, i32) -> !llvm.ptr<struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>>
    %7 = llvm.bitcast %6 : !llvm.ptr<struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>> to !llvm.ptr<struct<(array<8 x i16>)>>
    %8 = llvm.getelementptr %7[%1, %1] : (!llvm.ptr<struct<(array<8 x i16>)>>, i32, i32) -> !llvm.ptr<array<8 x i16>>
    %9 = llvm.getelementptr %8[%1, %1] : (!llvm.ptr<array<8 x i16>>, i32, i32) -> !llvm.ptr<i16>
    llvm.store %0, %9 : !llvm.ptr<i16>
    llvm.call @bar(%9) : (!llvm.ptr<i16>) -> ()
    llvm.return
  }
  llvm.func @bar(!llvm.ptr<i16>)
  llvm.func @foo_as1(%arg0: i32, %arg1: !llvm.ptr<array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>, 1>) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.getelementptr %arg1[%1, %1] : (!llvm.ptr<array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>, 1>, i32, i32) -> !llvm.ptr<struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>, 1>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>, 1>, i32, i32) -> !llvm.ptr<struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>, 1>
    %4 = llvm.getelementptr %3[%1, %1] : (!llvm.ptr<struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>, 1>, i32, i32) -> !llvm.ptr<struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>, 1>
    %5 = llvm.bitcast %4 : !llvm.ptr<struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>, 1> to !llvm.ptr<struct<(array<8 x i16>)>, 1>
    %6 = llvm.getelementptr %5[%1, %1] : (!llvm.ptr<struct<(array<8 x i16>)>, 1>, i32, i32) -> !llvm.ptr<array<8 x i16>, 1>
    %7 = llvm.getelementptr %6[%1, %1] : (!llvm.ptr<array<8 x i16>, 1>, i32, i32) -> !llvm.ptr<i16, 1>
    llvm.store %0, %7 : !llvm.ptr<i16, 1>
    llvm.call @bar_as1(%7) : (!llvm.ptr<i16, 1>) -> ()
    llvm.return
  }
  llvm.func @bar_as1(!llvm.ptr<i16, 1>)
}
