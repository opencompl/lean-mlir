module  {
  llvm.func @foo(%arg0: !llvm.ptr<struct<"struct.C", (ptr<struct<"struct.C">>, i32)>>) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr %arg0[%2, %2] : (!llvm.ptr<struct<"struct.C", (ptr<struct<"struct.C">>, i32)>>, i32, i32) -> !llvm.ptr<ptr<struct<"struct.C", (ptr<struct<"struct.C">>, i32)>>>
    %4 = llvm.load %3 : !llvm.ptr<ptr<struct<"struct.C", (ptr<struct<"struct.C">>, i32)>>>
    %5 = llvm.getelementptr %4[%2, %2] : (!llvm.ptr<struct<"struct.C", (ptr<struct<"struct.C">>, i32)>>, i32, i32) -> !llvm.ptr<ptr<struct<"struct.C", (ptr<struct<"struct.C">>, i32)>>>
    %6 = llvm.load %5 : !llvm.ptr<ptr<struct<"struct.C", (ptr<struct<"struct.C">>, i32)>>>
    llvm.store %6, %3 : !llvm.ptr<ptr<struct<"struct.C", (ptr<struct<"struct.C">>, i32)>>>
    %7 = llvm.getelementptr %arg0[%2, %1] : (!llvm.ptr<struct<"struct.C", (ptr<struct<"struct.C">>, i32)>>, i32, i32) -> !llvm.ptr<i32>
    %8 = llvm.load %7 : !llvm.ptr<i32>
    %9 = llvm.add %8, %0  : i32
    llvm.store %9, %7 : !llvm.ptr<i32>
    %10 = llvm.bitcast %6 : !llvm.ptr<struct<"struct.C", (ptr<struct<"struct.C">>, i32)>> to !llvm.ptr<i8>
    llvm.call @llvm.prefetch.p0i8(%10, %2, %2, %1) : (!llvm.ptr<i8>, i32, i32, i32) -> ()
    %11 = llvm.load %7 : !llvm.ptr<i32>
    llvm.return %11 : i32
  }
  llvm.func @llvm.prefetch.p0i8(!llvm.ptr<i8>, i32, i32, i32)
}
