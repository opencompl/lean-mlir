module  {
  llvm.mlir.global external constant @str("toulbroc'h\00")
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @llvm.objectsize.i64.p0i8(!llvm.ptr<i8>, i1, i1, i1) -> i64
  llvm.func @strdup(!llvm.ptr<i8>) -> !llvm.ptr<i8>
  llvm.func @__strdup(!llvm.ptr<i8>) -> !llvm.ptr<i8>
  llvm.func @strndup(!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @__strndup(!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @check_strdup(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @str : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @strdup(%4) : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %6 = llvm.call @llvm.objectsize.i64.p0i8(%5, %1, %0, %1) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.return %6 : i64
  }
  llvm.func @check_dunder_strdup(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @str : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @__strdup(%4) : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %6 = llvm.call @llvm.objectsize.i64.p0i8(%5, %1, %0, %1) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.return %6 : i64
  }
  llvm.func @check_strndup(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.addressof @str : !llvm.ptr<array<11 x i8>>
    %5 = llvm.getelementptr %4[%3, %3] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %6 = llvm.call @strndup(%5, %2) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %7 = llvm.call @llvm.objectsize.i64.p0i8(%6, %1, %0, %1) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.return %7 : i64
  }
  llvm.func @check_dunder_strndup(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.addressof @str : !llvm.ptr<array<11 x i8>>
    %5 = llvm.getelementptr %4[%3, %3] : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %6 = llvm.call @__strndup(%5, %2) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %7 = llvm.call @llvm.objectsize.i64.p0i8(%6, %1, %0, %1) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.return %7 : i64
  }
}
