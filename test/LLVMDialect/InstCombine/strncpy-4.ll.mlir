module  {
  llvm.mlir.global external constant @s4("1234\00567\00")
  llvm.func @strncpy(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @sink(!llvm.ptr<i8>, !llvm.ptr<i8>)
  llvm.func @fold_strncpy_overlap(%arg0: !llvm.ptr<i8>, %arg1: i64) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg0, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg0, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @call_strncpy_overlap(%arg0: !llvm.ptr<i8>, %arg1: i64) {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg0, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg0, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %4 = llvm.call @strncpy(%arg0, %arg0, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @fold_strncpy_s0(%arg0: !llvm.ptr<i8>, %arg1: i64) {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.addressof @s4 : !llvm.ptr<array<9 x i8>>
    %7 = llvm.getelementptr %6[%5, %4] : (!llvm.ptr<array<9 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %8 = llvm.call @strncpy(%arg0, %7, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %8) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %9 = llvm.call @strncpy(%arg0, %7, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %9) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %10 = llvm.call @strncpy(%arg0, %7, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %10) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %11 = llvm.call @strncpy(%arg0, %7, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %11) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %12 = llvm.call @strncpy(%arg0, %7, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %12) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @fold_strncpy_s(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @call_strncpy_s(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64) {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %4 = llvm.call @strncpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @sink(%arg0, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
}
