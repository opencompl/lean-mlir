module  {
  llvm.mlir.global external @ax() : !llvm.array<0 x i8>
  llvm.mlir.global external constant @s5("12345\00")
  llvm.mlir.global external constant @s5_3("12345\00xyz")
  llvm.func @strnlen(!llvm.ptr<i8>, i64) -> i64
  llvm.func @no_access_strnlen_p_n(%arg0: !llvm.ptr<i8>, %arg1: i64) -> i64 {
    %0 = llvm.call @strnlen(%arg0, %arg1) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %0 : i64
  }
  llvm.func @access_strnlen_p_2(%arg0: !llvm.ptr<i8>) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.call @strnlen(%arg0, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %1 : i64
  }
  llvm.func @access_strnlen_p_nz(%arg0: !llvm.ptr<i8>, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.or %arg1, %0  : i64
    %2 = llvm.call @strnlen(%arg0, %1) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @fold_strnlen_ax_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_ax_1() -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<0 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_s5_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @s5 : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_s5_4() -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @s5 : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_s5_5() -> i64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @s5 : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_s5_m1() -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @s5 : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_s5_3_p4_5() -> i64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @s5_3 : !llvm.ptr<array<9 x i8>>
    %4 = llvm.getelementptr %3[%2, %1] : (!llvm.ptr<array<9 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strnlen(%4, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %5 : i64
  }
  llvm.func @fold_strnlen_s5_3_p5_5() -> i64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @s5_3 : !llvm.ptr<array<9 x i8>>
    %4 = llvm.getelementptr %3[%2, %1] : (!llvm.ptr<array<9 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strnlen(%4, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %5 : i64
  }
  llvm.func @fold_strnlen_s5_3_p6_3() -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @s5_3 : !llvm.ptr<array<9 x i8>>
    %4 = llvm.getelementptr %3[%2, %1] : (!llvm.ptr<array<9 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strnlen(%4, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %5 : i64
  }
  llvm.func @call_strnlen_s5_3_p6_4() -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @s5_3 : !llvm.ptr<array<9 x i8>>
    %4 = llvm.getelementptr %3[%2, %1] : (!llvm.ptr<array<9 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strnlen(%4, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %5 : i64
  }
}
