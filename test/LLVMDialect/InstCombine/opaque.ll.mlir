module  {
  llvm.mlir.global external @_swift_slowAlloc() : !llvm.ptr<func<ptr<i8> (i64, i64)>>
  llvm.func @llvm.memcpy.p0i8.p0i8.i64(!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1)
  llvm.func @rt_swift_slowAlloc(i64, i64) -> !llvm.ptr<i8>
  llvm.func @_TwTkV(%arg0: !llvm.ptr<array<24 x i8>>, %arg1: !llvm.ptr<struct<"swift.opaque", opaque>>, %arg2: !llvm.ptr<struct<"swift.type", (i64)>>) -> !llvm.ptr<struct<"swift.opaque", opaque>> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(40 : i64) : i64
    %3 = llvm.bitcast %arg1 : !llvm.ptr<struct<"swift.opaque", opaque>> to !llvm.ptr<struct<"V", packed (struct<packed (struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>)>, struct<"Si", packed (i64)>, struct<"SQ", packed (array<8 x i8>)>, struct<"SQ", packed (array<8 x i8>)>, struct<"Si", packed (i64)>, struct<"swift.opaque", opaque>)>>
    %4 = llvm.call @rt_swift_slowAlloc(%2, %1) : (i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.bitcast %arg0 : !llvm.ptr<array<24 x i8>> to !llvm.ptr<ptr<i8>>
    llvm.store %4, %5 : !llvm.ptr<ptr<i8>>
    %6 = llvm.bitcast %4 : !llvm.ptr<i8> to !llvm.ptr<struct<"V", packed (struct<packed (struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>)>, struct<"Si", packed (i64)>, struct<"SQ", packed (array<8 x i8>)>, struct<"SQ", packed (array<8 x i8>)>, struct<"Si", packed (i64)>, struct<"swift.opaque", opaque>)>>
    %7 = llvm.bitcast %6 : !llvm.ptr<struct<"V", packed (struct<packed (struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>)>, struct<"Si", packed (i64)>, struct<"SQ", packed (array<8 x i8>)>, struct<"SQ", packed (array<8 x i8>)>, struct<"Si", packed (i64)>, struct<"swift.opaque", opaque>)>> to !llvm.ptr<i8>
    %8 = llvm.bitcast %3 : !llvm.ptr<struct<"V", packed (struct<packed (struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>)>, struct<"Si", packed (i64)>, struct<"SQ", packed (array<8 x i8>)>, struct<"SQ", packed (array<8 x i8>)>, struct<"Si", packed (i64)>, struct<"swift.opaque", opaque>)>> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%7, %8, %2, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    %9 = llvm.bitcast %6 : !llvm.ptr<struct<"V", packed (struct<packed (struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>)>, struct<"Si", packed (i64)>, struct<"SQ", packed (array<8 x i8>)>, struct<"SQ", packed (array<8 x i8>)>, struct<"Si", packed (i64)>, struct<"swift.opaque", opaque>)>> to !llvm.ptr<struct<"swift.opaque", opaque>>
    llvm.return %9 : !llvm.ptr<struct<"swift.opaque", opaque>>
  }
}
