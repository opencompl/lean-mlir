module  {
  llvm.mlir.global external constant @s4("1234\00")
  llvm.mlir.global external constant @a5("12345")
  llvm.func @strlcpy(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
  llvm.func @sink(!llvm.ptr<i8>, i64)
  llvm.func @fold_strlcpy_s0(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.addressof @s4 : !llvm.ptr<array<5 x i8>>
    %6 = llvm.getelementptr %5[%4, %3] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = llvm.call @strlcpy(%arg0, %6, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %7) : (!llvm.ptr<i8>, i64) -> ()
    %8 = llvm.call @strlcpy(%arg0, %6, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %8) : (!llvm.ptr<i8>, i64) -> ()
    %9 = llvm.call @strlcpy(%arg0, %6, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %9) : (!llvm.ptr<i8>, i64) -> ()
    llvm.return
  }
  llvm.func @fold_strlcpy_s1(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.addressof @s4 : !llvm.ptr<array<5 x i8>>
    %8 = llvm.getelementptr %7[%6, %5] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %9 = llvm.call @strlcpy(%arg0, %8, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %9) : (!llvm.ptr<i8>, i64) -> ()
    %10 = llvm.call @strlcpy(%arg0, %8, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr<i8>, i64) -> ()
    %11 = llvm.call @strlcpy(%arg0, %8, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %11) : (!llvm.ptr<i8>, i64) -> ()
    %12 = llvm.call @strlcpy(%arg0, %8, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr<i8>, i64) -> ()
    %13 = llvm.call @strlcpy(%arg0, %8, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %13) : (!llvm.ptr<i8>, i64) -> ()
    llvm.return
  }
  llvm.func @fold_strlcpy_s5(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mlir.addressof @s4 : !llvm.ptr<array<5 x i8>>
    %9 = llvm.getelementptr %8[%7, %7] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %10 = llvm.call @strlcpy(%arg0, %9, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr<i8>, i64) -> ()
    %11 = llvm.call @strlcpy(%arg0, %9, %5) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %11) : (!llvm.ptr<i8>, i64) -> ()
    %12 = llvm.call @strlcpy(%arg0, %9, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr<i8>, i64) -> ()
    %13 = llvm.call @strlcpy(%arg0, %9, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %13) : (!llvm.ptr<i8>, i64) -> ()
    %14 = llvm.call @strlcpy(%arg0, %9, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %14) : (!llvm.ptr<i8>, i64) -> ()
    %15 = llvm.call @strlcpy(%arg0, %9, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %15) : (!llvm.ptr<i8>, i64) -> ()
    %16 = llvm.call @strlcpy(%arg0, %9, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %16) : (!llvm.ptr<i8>, i64) -> ()
    %17 = llvm.call @strlcpy(%arg0, %9, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %17) : (!llvm.ptr<i8>, i64) -> ()
    llvm.return
  }
  llvm.func @fold_strlcpy_s_0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64) {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.call @strlcpy(%arg0, %arg1, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %3) : (!llvm.ptr<i8>, i64) -> ()
    %4 = llvm.call @strlcpy(%arg0, %arg1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %4) : (!llvm.ptr<i8>, i64) -> ()
    %5 = llvm.call @strlcpy(%0, %arg1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %5) : (!llvm.ptr<i8>, i64) -> ()
    llvm.return
  }
  llvm.func @call_strlcpy_s0_n(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64) {
    %0 = llvm.mlir.addressof @s4 : !llvm.ptr<array<5 x i8>>
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.addressof @s4 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.addressof @s4 : !llvm.ptr<array<5 x i8>>
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.call @strlcpy(%arg0, %arg1, %7) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %8) : (!llvm.ptr<i8>, i64) -> ()
    %9 = llvm.call @strlcpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %9) : (!llvm.ptr<i8>, i64) -> ()
    %10 = llvm.or %arg2, %6  : i64
    %11 = llvm.call @strlcpy(%arg0, %arg1, %10) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %11) : (!llvm.ptr<i8>, i64) -> ()
    %12 = llvm.getelementptr %5[%4, %3] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %13 = llvm.call @strlcpy(%arg0, %12, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %13) : (!llvm.ptr<i8>, i64) -> ()
    %14 = llvm.getelementptr %2[%4, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %15 = llvm.call @strlcpy(%arg0, %14, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %15) : (!llvm.ptr<i8>, i64) -> ()
    %16 = llvm.getelementptr %0[%4, %4] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %17 = llvm.call @strlcpy(%arg0, %16, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %17) : (!llvm.ptr<i8>, i64) -> ()
    llvm.return
  }
  llvm.func @fold_strlcpy_a5(%arg0: !llvm.ptr<i8>, %arg1: i64) {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %8 = llvm.getelementptr %7[%6, %6] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %9 = llvm.call @strlcpy(%arg0, %8, %5) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %9) : (!llvm.ptr<i8>, i64) -> ()
    %10 = llvm.call @strlcpy(%arg0, %8, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr<i8>, i64) -> ()
    %11 = llvm.call @strlcpy(%arg0, %8, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %11) : (!llvm.ptr<i8>, i64) -> ()
    %12 = llvm.call @strlcpy(%arg0, %8, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr<i8>, i64) -> ()
    %13 = llvm.call @strlcpy(%arg0, %8, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %13) : (!llvm.ptr<i8>, i64) -> ()
    %14 = llvm.call @strlcpy(%arg0, %8, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i64
    llvm.call @sink(%arg0, %14) : (!llvm.ptr<i8>, i64) -> ()
    llvm.return
  }
}
