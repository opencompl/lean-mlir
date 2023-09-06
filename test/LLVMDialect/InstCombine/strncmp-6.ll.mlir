module  {
  llvm.mlir.global external constant @a("abcdef\7F")
  llvm.mlir.global external constant @b("abcdef\80")
  llvm.func @strncmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
  llvm.func @fold_strncmp_cst_cst(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.addressof @b : !llvm.ptr<array<7 x i8>>
    %4 = llvm.mlir.addressof @b : !llvm.ptr<array<7 x i8>>
    %5 = llvm.mlir.constant(6 : i64) : i64
    %6 = llvm.mlir.addressof @a : !llvm.ptr<array<7 x i8>>
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.mlir.addressof @a : !llvm.ptr<array<7 x i8>>
    %10 = llvm.getelementptr %9[%8, %7] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %11 = llvm.getelementptr %6[%8, %5] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %12 = llvm.getelementptr %4[%8, %7] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %13 = llvm.getelementptr %3[%8, %5] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %14 = llvm.call @strncmp(%10, %12, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %15 = llvm.getelementptr %arg0[%8] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %14, %15 : !llvm.ptr<i32>
    %16 = llvm.call @strncmp(%12, %10, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %17 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %16, %17 : !llvm.ptr<i32>
    %18 = llvm.call @strncmp(%11, %13, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %19 = llvm.getelementptr %arg0[%2] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %18, %19 : !llvm.ptr<i32>
    %20 = llvm.call @strncmp(%13, %11, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %21 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %20, %21 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @fold_strncmp_cst_var(%arg0: !llvm.ptr<i32>, %arg1: i64) {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.addressof @b : !llvm.ptr<array<7 x i8>>
    %4 = llvm.mlir.addressof @b : !llvm.ptr<array<7 x i8>>
    %5 = llvm.mlir.constant(6 : i64) : i64
    %6 = llvm.mlir.addressof @a : !llvm.ptr<array<7 x i8>>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.addressof @a : !llvm.ptr<array<7 x i8>>
    %9 = llvm.getelementptr %8[%7, %7] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %10 = llvm.getelementptr %6[%7, %5] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %11 = llvm.getelementptr %4[%7, %7] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %12 = llvm.getelementptr %3[%7, %5] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %13 = llvm.call @strncmp(%9, %11, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %14 = llvm.getelementptr %arg0[%7] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %13, %14 : !llvm.ptr<i32>
    %15 = llvm.call @strncmp(%11, %9, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %16 = llvm.getelementptr %arg0[%2] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %15, %16 : !llvm.ptr<i32>
    %17 = llvm.call @strncmp(%10, %12, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %18 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %17, %18 : !llvm.ptr<i32>
    %19 = llvm.call @strncmp(%12, %10, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %20 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %19, %20 : !llvm.ptr<i32>
    llvm.return
  }
}
