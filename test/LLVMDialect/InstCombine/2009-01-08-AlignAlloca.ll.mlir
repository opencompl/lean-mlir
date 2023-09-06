module  {
  llvm.func @bar(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x !llvm.struct<"struct.Key", (struct<(i32, i32)>)> : (i32) -> !llvm.ptr<struct<"struct.Key", (struct<(i32, i32)>)>>
    %3 = llvm.alloca %1 x i32 : (i32) -> !llvm.ptr<i32>
    %4 = llvm.bitcast %0 : i32 to i32
    %5 = llvm.getelementptr %2[%0, %0] : (!llvm.ptr<struct<"struct.Key", (struct<(i32, i32)>)>>, i32, i32) -> !llvm.ptr<struct<(i32, i32)>>
    %6 = llvm.getelementptr %5[%0, %0] : (!llvm.ptr<struct<(i32, i32)>>, i32, i32) -> !llvm.ptr<i32>
    llvm.store %0, %6 : !llvm.ptr<i32>
    %7 = llvm.getelementptr %5[%0, %1] : (!llvm.ptr<struct<(i32, i32)>>, i32, i32) -> !llvm.ptr<i32>
    llvm.store %0, %7 : !llvm.ptr<i32>
    %8 = llvm.getelementptr %2[%0, %0] : (!llvm.ptr<struct<"struct.Key", (struct<(i32, i32)>)>>, i32, i32) -> !llvm.ptr<struct<(i32, i32)>>
    %9 = llvm.bitcast %8 : !llvm.ptr<struct<(i32, i32)>> to !llvm.ptr<i64>
    llvm.store %arg0, %9 : !llvm.ptr<i64>
    %10 = llvm.call @foo(%2, %3) : (!llvm.ptr<struct<"struct.Key", (struct<(i32, i32)>)>>, !llvm.ptr<i32>) -> i32
    %11 = llvm.load %3 : !llvm.ptr<i32>
    llvm.return %11 : i32
  }
  llvm.func @foo(...) -> i32
}
