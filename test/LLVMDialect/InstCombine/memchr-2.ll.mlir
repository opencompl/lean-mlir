module  {
  llvm.mlir.global external @ax() : !llvm.array<0 x i8>
  llvm.mlir.global external constant @a12345("\01\02\03\04\05")
  llvm.mlir.global external constant @a123f45("\01\02\03\F4\05")
  llvm.func @memchr(!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
  llvm.func @fold_memchr_a12345_6_n(%arg0: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memchr(%3, %0, %arg0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_memchr_a12345_4_2() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memchr_a12345_4_3() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memchr_a12345_3_3() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memchr_a12345_3_9() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memchr_a123f45_500_9() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(500 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a123f45 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_a12345_3_n(%arg0: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memchr(%3, %0, %arg0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_a12345_259_n(%arg0: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(259 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memchr(%3, %0, %arg0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_ax_1_n(%arg0: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memchr(%3, %0, %arg0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
}
