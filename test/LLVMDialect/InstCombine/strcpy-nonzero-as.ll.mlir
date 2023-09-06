module  {
  llvm.mlir.global private constant @str("exactly 16 chars\00")
  llvm.func @strcpy(!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>) -> !llvm.ptr<i8, 200>
  llvm.func @stpcpy(!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>) -> !llvm.ptr<i8, 200>
  llvm.func @strncpy(!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>, i64) -> !llvm.ptr<i8, 200>
  llvm.func @stpncpy(!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>, i64) -> !llvm.ptr<i8, 200>
  llvm.func @test_strcpy_to_memcpy(%arg0: !llvm.ptr<i8, 200>) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @str : !llvm.ptr<array<17 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<17 x i8>>, i64, i64) -> !llvm.ptr<i8, 200>
    %3 = llvm.call @strcpy(%arg0, %2) : (!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>) -> !llvm.ptr<i8, 200>
    llvm.return
  }
  llvm.func @test_stpcpy_to_memcpy(%arg0: !llvm.ptr<i8, 200>) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @str : !llvm.ptr<array<17 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<17 x i8>>, i64, i64) -> !llvm.ptr<i8, 200>
    %3 = llvm.call @stpcpy(%arg0, %2) : (!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>) -> !llvm.ptr<i8, 200>
    llvm.return
  }
  llvm.func @test_stpcpy_to_strcpy(%arg0: !llvm.ptr<i8, 200>, %arg1: !llvm.ptr<i8, 200>) {
    %0 = llvm.call @stpcpy(%arg0, %arg1) : (!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>) -> !llvm.ptr<i8, 200>
    llvm.return
  }
  llvm.func @test_strncpy_to_memcpy(%arg0: !llvm.ptr<i8, 200>) {
    %0 = llvm.mlir.constant(17 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @str : !llvm.ptr<array<17 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<17 x i8>>, i64, i64) -> !llvm.ptr<i8, 200>
    %4 = llvm.call @strncpy(%arg0, %3, %0) : (!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>, i64) -> !llvm.ptr<i8, 200>
    llvm.return
  }
  llvm.func @test_stpncpy_to_memcpy(%arg0: !llvm.ptr<i8, 200>) {
    %0 = llvm.mlir.constant(17 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @str : !llvm.ptr<array<17 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<17 x i8>>, i64, i64) -> !llvm.ptr<i8, 200>
    %4 = llvm.call @stpncpy(%arg0, %3, %0) : (!llvm.ptr<i8, 200>, !llvm.ptr<i8, 200>, i64) -> !llvm.ptr<i8, 200>
    llvm.return
  }
}
