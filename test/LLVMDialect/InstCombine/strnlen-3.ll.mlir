module  {
  llvm.mlir.global external @sx() : !llvm.array<0 x i8>
  llvm.mlir.global external constant @a3("123")
  llvm.mlir.global external constant @s3("123\00")
  llvm.mlir.global external constant @s5("12345\00")
  llvm.mlir.global external constant @s5_3("12345\00abc\00")
  llvm.func @strnlen(!llvm.ptr<i8>, i64) -> i64
  llvm.func @fold_strnlen_sx_pi_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @sx : !llvm.ptr<array<0 x i8>>
    %2 = llvm.getelementptr %1[%0, %arg0] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @strnlen(%2, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @call_strnlen_sx_pi_n(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @sx : !llvm.ptr<array<0 x i8>>
    %2 = llvm.getelementptr %1[%0, %arg0] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @strnlen(%2, %arg1) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @call_strnlen_a3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @a3 : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %arg0] : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @call_strnlen_a3_pi_3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @a3 : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %arg0] : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_s3_pi_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr<array<4 x i8>>
    %2 = llvm.getelementptr %1[%0, %arg0] : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @strnlen(%2, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @call_strnlen_s5_pi_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @s5 : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_s5_3_pi_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @s5_3 : !llvm.ptr<array<10 x i8>>
    %3 = llvm.getelementptr %2[%1, %arg0] : (!llvm.ptr<array<10 x i8>>, i32, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @call_strnlen_s5_3_pi_n(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr<array<10 x i8>>
    %2 = llvm.getelementptr %1[%0, %arg0] : (!llvm.ptr<array<10 x i8>>, i32, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @strnlen(%2, %arg1) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @fold_strnlen_a3_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr<array<3 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @strnlen(%2, %arg0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @fold_strnlen_s3_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr<array<4 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @strnlen(%2, %arg0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @fold_strnlen_a3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @a3 : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %arg0] : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_s3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @s3 : !llvm.ptr<array<4 x i8>>
    %3 = llvm.getelementptr %2[%1, %arg0] : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_s3_pi_3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @s3 : !llvm.ptr<array<4 x i8>>
    %3 = llvm.getelementptr %2[%1, %arg0] : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_s3_pi_n(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr<array<4 x i8>>
    %2 = llvm.getelementptr %1[%0, %arg0] : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @strnlen(%2, %arg1) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @call_strnlen_s5_3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @s5_3 : !llvm.ptr<array<10 x i8>>
    %3 = llvm.getelementptr %2[%1, %arg0] : (!llvm.ptr<array<10 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
}
