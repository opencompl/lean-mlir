module  {
  llvm.mlir.global external constant @str("a\00")
  llvm.mlir.global external constant @str2("abc")
  llvm.mlir.global external constant @str3("abcd")
  llvm.func @strncpy(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @fill_with_zeros(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @str : !llvm.ptr<array<2 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<2 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strncpy(%arg0, %3, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return
  }
  llvm.func @fill_with_zeros2(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @str2 : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strncpy(%arg0, %3, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return
  }
  llvm.func @fill_with_zeros3(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @str3 : !llvm.ptr<array<4 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strncpy(%arg0, %3, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return
  }
  llvm.func @fill_with_zeros4(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @str3 : !llvm.ptr<array<4 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strncpy(%arg0, %3, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return
  }
  llvm.func @no_simplify(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(129 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @str3 : !llvm.ptr<array<4 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strncpy(%arg0, %3, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return
  }
}
