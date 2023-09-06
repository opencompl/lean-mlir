module  {
  llvm.mlir.global external @ax() : !llvm.array<0 x i8>
  llvm.mlir.global external @ax1() : !llvm.array<1 x i8>
  llvm.mlir.global external constant @a12345("\01\02\03\04\05")
  llvm.func @memrchr(!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
  llvm.func @call_memrchr_a12345_c_ui32max_p1(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %arg0, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_memrchr_ax1_c_ui32max_p2(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(4294967297 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @ax1 : !llvm.ptr<array<1 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<1 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %arg0, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_memrchr_ax_c_ui32max_p2(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(4294967297 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %arg0, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_memrchr_a12345_c_6(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %arg0, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_memrchr_a12345_c_szmax(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @memrchr(%3, %arg0, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
}
