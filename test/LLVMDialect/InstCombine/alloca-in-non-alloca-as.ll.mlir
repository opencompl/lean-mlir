module  {
  llvm.func @use(!llvm.ptr<i8>, !llvm.ptr<ptr<i32>>)
  llvm.func weak @__omp_offloading_802_ea0109_main_l8(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.undef : !llvm.ptr<i32>
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.alloca %1 x i8 : (i64) -> !llvm.ptr<i8>
    %3 = llvm.bitcast %2 : !llvm.ptr<i8> to !llvm.ptr<ptr<i32>>
    llvm.store %0, %3 : !llvm.ptr<ptr<i32>>
    llvm.call @use(%2, %3) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i32>>) -> ()
    llvm.return
  }
  llvm.func @spam(%arg0: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %1 x !llvm.array<30 x struct<"struct.widget", (array<8 x i8>)>> : (i32) -> !llvm.ptr<array<30 x struct<"struct.widget", (array<8 x i8>)>>>
    %3 = llvm.getelementptr %2[%0, %0] : (!llvm.ptr<array<30 x struct<"struct.widget", (array<8 x i8>)>>>, i64, i64) -> !llvm.ptr<struct<"struct.widget", (array<8 x i8>)>>
    llvm.call @zot(%3) : (!llvm.ptr<struct<"struct.widget", (array<8 x i8>)>>) -> ()
    llvm.return
  }
  llvm.func @zot(!llvm.ptr<struct<"struct.widget", (array<8 x i8>)>>)
}
