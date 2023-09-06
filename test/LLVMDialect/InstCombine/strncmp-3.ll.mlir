module  {
  llvm.mlir.global external @ax() : !llvm.array<0 x i8>
  llvm.mlir.global external @bx() : !llvm.array<0 x i8>
  llvm.mlir.global external constant @a12345("\01\02\03\04\05")
  llvm.mlir.global external constant @a123456("\01\02\03\04\05\06")
  llvm.func @strncmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
  llvm.func @call_strncmp_ax_bx_uimax_p1() -> i32 {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.mlir.addressof @bx : !llvm.ptr<array<0 x i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @strncmp(%4, %5, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %6 : i32
  }
  llvm.func @call_strncmp_ax_bx_uimax_p2() -> i32 {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    %1 = llvm.mlir.addressof @bx : !llvm.ptr<array<0 x i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @strncmp(%4, %5, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %6 : i32
  }
  llvm.func @fold_strncmp_a12345_2_uimax_p2() -> i32 {
    %0 = llvm.mlir.constant(4294967297 : i64) : i64
    %1 = llvm.mlir.addressof @a123456 : !llvm.ptr<array<6 x i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @strncmp(%4, %5, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %6 : i32
  }
  llvm.func @fold_strncmp_a12345_2_uimax_p3() -> i32 {
    %0 = llvm.mlir.constant(4294967298 : i64) : i64
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr<array<5 x i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a123456 : !llvm.ptr<array<6 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.call @strncmp(%4, %5, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %6 : i32
  }
}
