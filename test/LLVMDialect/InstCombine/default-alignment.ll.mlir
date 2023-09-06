module  {
  llvm.func @t(%arg0: !llvm.ptr<struct<"Foo", packed (i8, f80)>>) -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0, %0] : (!llvm.ptr<struct<"Foo", packed (i8, f80)>>, i32, i32) -> !llvm.ptr<i8>
    %2 = llvm.load %1 : !llvm.ptr<i8>
    llvm.return %2 : i8
  }
}
