module  {
  llvm.mlir.global external constant @a4("1234")
  llvm.mlir.global external constant @s4("1234\00")
  llvm.mlir.global private constant @str("4\00\00\00")
  llvm.mlir.global private constant @str.1("4\00\00\00\00\00\00\00\00\00")
  llvm.mlir.global private constant @str.2("1234\00\00\00\00\00\00")
  llvm.mlir.global private constant @str.3("4\00\00\00")
  llvm.mlir.global private constant @str.4("4\00\00\00\00\00\00\00\00\00")
  llvm.mlir.global private constant @str.5("1234\00\00\00\00\00\00")
  llvm.func @stpncpy(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @sink(!llvm.ptr<i8>, !llvm.ptr<i8>)
  llvm.func @fold_stpncpy_overlap(%arg0: !llvm.ptr<i8>, %arg1: i64) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @stpncpy(%arg0, %arg0, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %3 = llvm.call @stpncpy(%arg0, %arg0, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @call_stpncpy_overlap(%arg0: !llvm.ptr<i8>, %arg1: i64) {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.call @stpncpy(%arg0, %arg0, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %3 = llvm.call @stpncpy(%arg0, %arg0, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %4 = llvm.call @stpncpy(%arg0, %arg0, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @fold_stpncpy_s0(%arg0: !llvm.ptr<i8>, %arg1: i64) {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.addressof @s4 : !llvm.ptr<array<5 x i8>>
    %7 = llvm.getelementptr %6[%5, %4] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %8 = llvm.call @stpncpy(%arg0, %7, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %8) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %9 = llvm.call @stpncpy(%arg0, %7, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %9) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %10 = llvm.call @stpncpy(%arg0, %7, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %10) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %11 = llvm.call @stpncpy(%arg0, %7, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %11) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %12 = llvm.call @stpncpy(%arg0, %7, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %12) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @fold_stpncpy_s1(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.addressof @s4 : !llvm.ptr<array<5 x i8>>
    %8 = llvm.getelementptr %7[%6, %5] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %9 = llvm.call @stpncpy(%arg0, %8, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %9) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %10 = llvm.call @stpncpy(%arg0, %8, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %10) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %11 = llvm.call @stpncpy(%arg0, %8, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %11) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %12 = llvm.call @stpncpy(%arg0, %8, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %12) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %13 = llvm.call @stpncpy(%arg0, %8, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %13) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @fold_stpncpy_s4(%arg0: !llvm.ptr<i8>, %arg1: i64) {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.addressof @s4 : !llvm.ptr<array<5 x i8>>
    %8 = llvm.getelementptr %7[%6, %6] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %9 = llvm.call @stpncpy(%arg0, %8, %5) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %9) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %10 = llvm.call @stpncpy(%arg0, %8, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %10) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %11 = llvm.call @stpncpy(%arg0, %8, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %11) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %12 = llvm.call @stpncpy(%arg0, %8, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %12) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %13 = llvm.call @stpncpy(%arg0, %8, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %13) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %14 = llvm.call @stpncpy(%arg0, %8, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %14) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @call_stpncpy_xx_n(%arg0: !llvm.ptr<i8>, %arg1: i64) {
    %0 = llvm.mlir.addressof @s4 : !llvm.ptr<array<5 x i8>>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr<array<5 x i8>>
    %2 = llvm.mlir.addressof @a4 : !llvm.ptr<array<4 x i8>>
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.addressof @a4 : !llvm.ptr<array<4 x i8>>
    %6 = llvm.getelementptr %5[%4, %3] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = llvm.call @stpncpy(%arg0, %6, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %7) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %8 = llvm.getelementptr %2[%4, %4] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %9 = llvm.call @stpncpy(%arg0, %8, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %9) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %10 = llvm.getelementptr %1[%4, %3] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %11 = llvm.call @stpncpy(%arg0, %10, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %11) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %12 = llvm.getelementptr %0[%4, %4] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %13 = llvm.call @stpncpy(%arg0, %12, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %13) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @fold_stpncpy_a4(%arg0: !llvm.ptr<i8>, %arg1: i64) {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mlir.addressof @a4 : !llvm.ptr<array<4 x i8>>
    %9 = llvm.getelementptr %8[%7, %7] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %10 = llvm.call @stpncpy(%arg0, %9, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %10) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %11 = llvm.call @stpncpy(%arg0, %9, %5) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %11) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %12 = llvm.call @stpncpy(%arg0, %9, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %12) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %13 = llvm.call @stpncpy(%arg0, %9, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %13) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %14 = llvm.call @stpncpy(%arg0, %9, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %14) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %15 = llvm.call @stpncpy(%arg0, %9, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %15) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %16 = llvm.call @stpncpy(%arg0, %9, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %16) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @fold_stpncpy_s(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @stpncpy(%arg0, %arg1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %3 = llvm.call @stpncpy(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @call_stpncpy_s(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.call @stpncpy(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %2 = llvm.call @stpncpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
}
