module  {
  llvm.mlir.global weak_odr constant @real_init("y\00")
  llvm.mlir.global weak constant @fake_init("y\00")
  llvm.mlir.global private constant @".str"("y\00")
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.addressof @".str" : !llvm.ptr<array<2 x i8>>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @fake_init : !llvm.ptr<array<2 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<2 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.getelementptr %0[%1, %1] : (!llvm.ptr<array<2 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @strcmp(%3, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    llvm.return %5 : i32
  }
  llvm.func @bar() -> i32 {
    %0 = llvm.mlir.addressof @".str" : !llvm.ptr<array<2 x i8>>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @real_init : !llvm.ptr<array<2 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<2 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.getelementptr %0[%1, %1] : (!llvm.ptr<array<2 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @strcmp(%3, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    llvm.return %5 : i32
  }
  llvm.func @strcmp(!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
}
