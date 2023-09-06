module  {
  llvm.mlir.global internal constant @".str"("%d\0A\00")
  llvm.func @main(%arg0: i32, %arg1: !llvm.ptr<ptr<i8>>) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr<array<4 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @printf(%3, %1) : (!llvm.ptr<i8>, i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @printf(!llvm.ptr<i8>, ...) -> i32
}
