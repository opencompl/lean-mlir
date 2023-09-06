module  {
  llvm.mlir.global external constant @a5("12345")
  llvm.func @memcmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
  llvm.func @fold_memcmp_a5_a5p5_n(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %1[%2, %0] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @memcmp(%4, %5, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %6 : i32
  }
  llvm.func @fold_memcmp_a5p5_a5p5_n(%arg0: i64) -> i32 {
    %0 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %0[%2, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @memcmp(%4, %5, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %6 : i32
  }
  llvm.func @fold_memcmp_a5pi_a5p5_n(%arg0: i32, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %arg0] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %1[%2, %0] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @memcmp(%4, %5, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %6 : i32
  }
}
