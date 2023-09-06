module  {
  llvm.mlir.global external @ax() : !llvm.array<0 x i8>
  llvm.mlir.global external constant @a12345("\01\02\03\04\05")
  llvm.mlir.global external constant @a123123("\01\02\03\01\02\03")
  llvm.func @memrchr(!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
  llvm.func @fold_memrchr_ax_c_0(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %arg0, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345_3_0() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345_1_1() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345_5_1() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a123123_1_1() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a123123 : !llvm.ptr<array<6 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a123123_3_1() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a123123 : !llvm.ptr<array<6 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_ax_c_1(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %arg0, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345_5_5() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345_5_4() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345_4_5() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345p1_1_4() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345p1_2_4() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %5 = llvm.getelementptr %4[%3, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @memrchr(%5, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %6 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345_2_5() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345_0_n(%arg0: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @memrchr(%2, %0, %arg0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %3 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345_3_n(%arg0: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %0, %arg0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a12345_5_n(%arg0: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %0, %arg0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a123123_3_5() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a123123 : !llvm.ptr<array<6 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a123123_3_6() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a123123 : !llvm.ptr<array<6 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a123123_2_6() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a123123 : !llvm.ptr<array<6 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a123123_1_6() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a123123 : !llvm.ptr<array<6 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @memrchr(%4, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a123123_0_6() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a123123 : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_memrchr_a123123_0_n(%arg0: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr<array<6 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @memrchr(%2, %0, %arg0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %3 : !llvm.ptr<i8>
  }
  llvm.func @call_memrchr_a123123_3_n(%arg0: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a123123 : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %0, %arg0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_memrchr_a123123_2_n(%arg0: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a123123 : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %0, %arg0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_memrchr_a123123_1_n(%arg0: i64) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a123123 : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %0, %arg0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
}
