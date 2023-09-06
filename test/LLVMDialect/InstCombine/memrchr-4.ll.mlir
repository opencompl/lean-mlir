module  {
  llvm.mlir.global external constant @a11111("\01\01\01\01\01")
  llvm.mlir.global external constant @a1110111("\01\01\01\00\01\01\01")
  llvm.func @memrchr(!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
  llvm.func @fold_memrchr_a11111_c_5(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @a11111 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %arg0, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a11111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @a11111 : !llvm.ptr<array<5 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @memrchr(%2, %arg0, %arg1) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %3 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a1110111_c_3(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @a1110111 : !llvm.ptr<array<7 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %arg0, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_memrchr_a1110111_c_4(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @a1110111 : !llvm.ptr<array<7 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %arg0, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_memrchr_a1110111_c_7(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @a1110111 : !llvm.ptr<array<7 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %arg0, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_memrchr_a1110111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr<array<7 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @memrchr(%2, %arg0, %arg1) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %3 : !llvm.ptr<i8>
  }
}
