module  {
  llvm.mlir.global private constant @".str"("Hello world\0A\00")
  llvm.mlir.global private constant @".str2"("%s\00")
  llvm.func @test1(%arg0: !llvm.ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr<array<13 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @fprintf(%arg0, %2) : (!llvm.ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>, !llvm.ptr<i8>) -> i32
    llvm.return
  }
  llvm.func @test2(%arg0: !llvm.ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr<array<3 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @fprintf(%arg0, %2, %arg1) : (!llvm.ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    llvm.return
  }
  llvm.func @fprintf(!llvm.ptr<struct<"struct.__sFILE", (ptr<i8>, i32, i32, i16, i16, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, ptr<i8>, ptr<func<i32 (ptr<i8>)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, ptr<func<i64 (ptr<i8>, i64, i32)>>, ptr<func<i32 (ptr<i8>, ptr<i8>, i32)>>, struct<"struct.__sbuf", (ptr<i8>, i32)>, ptr<struct<"struct.__sFILEX", opaque>>, i32, array<3 x i8>, array<1 x i8>, struct<"struct.__sbuf", (ptr<i8>, i32)>, i32, i64)>>, !llvm.ptr<i8>, ...) -> i32
}
