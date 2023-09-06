module  {
  llvm.mlir.global private constant @".str"("%c\00")
  llvm.func @foo() {
    %0 = llvm.mlir.constant(97 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @printf(%3, %0) : (!llvm.ptr<i8>, i32) -> i32
    llvm.return
  }
  llvm.func @printf(!llvm.ptr<i8>, ...) -> i32
}
