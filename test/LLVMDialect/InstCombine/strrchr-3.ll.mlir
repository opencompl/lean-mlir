module  {
  llvm.mlir.global external constant @s10("0123456789\00")
  llvm.func @strrchr(!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
  llvm.func @fold_strrchr_sp10_x(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @s10 : !llvm.ptr<array<11 x i8>>
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strrchr(%3, %arg0) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_strrchr_sp9_x(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @s10 : !llvm.ptr<array<11 x i8>>
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strrchr(%3, %arg0) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_strrchr_sp2_x(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @s10 : !llvm.ptr<array<11 x i8>>
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strrchr(%3, %arg0) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @call_strrchr_sp1_x(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @s10 : !llvm.ptr<array<11 x i8>>
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strrchr(%3, %arg0) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
}
