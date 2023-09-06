module  {
  llvm.mlir.global internal constant @str("%llx\0A\00")
  llvm.func @printf(!llvm.ptr<i8>, ...) -> i32
  llvm.func @main(%arg0: i32, %arg1: !llvm.ptr<ptr<i8>>) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @str : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr<array<6 x i8>>, i32, i64) -> !llvm.ptr<i8>
    %4 = llvm.load %arg1 : !llvm.ptr<ptr<i8>>
    %5 = llvm.ptrtoint %4 : !llvm.ptr<i8> to i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.call @printf(%3, %6) : (!llvm.ptr<i8>, i64) -> i32
    llvm.return %1 : i32
  }
}
