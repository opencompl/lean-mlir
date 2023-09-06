module  {
  llvm.mlir.global external constant @a5("%s\0045")
  llvm.func @strchr(!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
  llvm.func @strrchr(!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
  llvm.func @strcmp(!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
  llvm.func @strncmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
  llvm.func @strstr(!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
  llvm.func @stpcpy(!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
  llvm.func @strcpy(!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
  llvm.func @stpncpy(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @strncpy(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @strlen(!llvm.ptr<i8>) -> i64
  llvm.func @strnlen(!llvm.ptr<i8>, i64) -> i64
  llvm.func @strpbrk(!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
  llvm.func @strspn(!llvm.ptr<i8>, !llvm.ptr<i8>) -> i64
  llvm.func @strcspn(!llvm.ptr<i8>, !llvm.ptr<i8>) -> i64
  llvm.func @atoi(!llvm.ptr<i8>) -> i32
  llvm.func @atol(!llvm.ptr<i8>) -> i64
  llvm.func @atoll(!llvm.ptr<i8>) -> i64
  llvm.func @strtol(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
  llvm.func @strtoll(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
  llvm.func @strtoul(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
  llvm.func @strtoull(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
  llvm.func @sprintf(!llvm.ptr<i8>, !llvm.ptr<i8>, ...) -> i32
  llvm.func @snprintf(!llvm.ptr<i8>, i64, !llvm.ptr<i8>, ...) -> i32
  llvm.func @fold_strchr_past_end() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strchr(%3, %1) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_strcmp_past_end(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %5 = llvm.getelementptr %4[%3, %3] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.getelementptr %2[%3, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = llvm.call @strcmp(%5, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %7, %8 : !llvm.ptr<i32>
    %9 = llvm.call @strcmp(%6, %5) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    %10 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %9, %10 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @fold_strncmp_past_end(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %6 = llvm.getelementptr %5[%4, %4] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = llvm.getelementptr %3[%4, %2] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %8 = llvm.call @strncmp(%6, %7, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %9 = llvm.getelementptr %arg0[%4] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %8, %9 : !llvm.ptr<i32>
    %10 = llvm.call @strncmp(%7, %6, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %11 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %10, %11 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @fold_strrchr_past_end(%arg0: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strrchr(%3, %1) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_strstr_past_end(%arg0: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %5 = llvm.getelementptr %4[%3, %3] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.getelementptr %2[%3, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = llvm.call @strstr(%5, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<ptr<i8>>, i32) -> !llvm.ptr<ptr<i8>>
    llvm.store %7, %8 : !llvm.ptr<ptr<i8>>
    %9 = llvm.call @strstr(%6, %5) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    %10 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<ptr<i8>>, i32) -> !llvm.ptr<ptr<i8>>
    llvm.store %9, %10 : !llvm.ptr<ptr<i8>>
    llvm.return
  }
  llvm.func @fold_strlen_past_end() -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strlen(%3) : (!llvm.ptr<i8>) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_stpcpy_past_end(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strcpy(%arg0, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_strcpy_past_end(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strcpy(%arg0, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    llvm.return %4 : !llvm.ptr<i8>
  }
  llvm.func @fold_stpncpy_past_end(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strncpy(%arg0, %4, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_strncpy_past_end(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %4 = llvm.getelementptr %3[%2, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strncpy(%arg0, %4, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return %5 : !llvm.ptr<i8>
  }
  llvm.func @fold_strpbrk_past_end(%arg0: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %5 = llvm.getelementptr %4[%3, %3] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.getelementptr %2[%3, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = llvm.call @strpbrk(%5, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<ptr<i8>>, i32) -> !llvm.ptr<ptr<i8>>
    llvm.store %7, %8 : !llvm.ptr<ptr<i8>>
    %9 = llvm.call @strpbrk(%6, %5) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    %10 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<ptr<i8>>, i32) -> !llvm.ptr<ptr<i8>>
    llvm.store %9, %10 : !llvm.ptr<ptr<i8>>
    llvm.return
  }
  llvm.func @fold_strspn_past_end(%arg0: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %5 = llvm.getelementptr %4[%3, %3] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.getelementptr %2[%3, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = llvm.call @strspn(%5, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i64
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %7, %8 : !llvm.ptr<i64>
    %9 = llvm.call @strspn(%6, %5) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i64
    %10 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %9, %10 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @fold_strcspn_past_end(%arg0: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %5 = llvm.getelementptr %4[%3, %3] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.getelementptr %2[%3, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = llvm.call @strcspn(%5, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i64
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %7, %8 : !llvm.ptr<i64>
    %9 = llvm.call @strcspn(%6, %5) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i64
    %10 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %9, %10 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @fold_atoi_past_end() -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @atoi(%3) : (!llvm.ptr<i8>) -> i32
    llvm.return %4 : i32
  }
  llvm.func @fold_atol_strtol_past_end(%arg0: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.constant(5 : i32) : i32
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %11 = llvm.getelementptr %10[%9, %8] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %12 = llvm.call @atol(%11) : (!llvm.ptr<i8>) -> i64
    %13 = llvm.getelementptr %arg0[%9] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %12, %13 : !llvm.ptr<i64>
    %14 = llvm.call @atoll(%11) : (!llvm.ptr<i8>) -> i64
    %15 = llvm.getelementptr %arg0[%7] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %14, %15 : !llvm.ptr<i64>
    %16 = llvm.call @strtol(%11, %6, %9) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %17 = llvm.getelementptr %arg0[%5] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %16, %17 : !llvm.ptr<i64>
    %18 = llvm.call @strtoul(%11, %6, %4) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %19 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %18, %19 : !llvm.ptr<i64>
    %20 = llvm.call @strtoll(%11, %6, %2) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %21 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %20, %21 : !llvm.ptr<i64>
    %22 = llvm.call @strtoul(%11, %6, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    %23 = llvm.getelementptr %arg0[%8] : (!llvm.ptr<i64>, i32) -> !llvm.ptr<i64>
    llvm.store %22, %23 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @fold_sprintf_past_end(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %5 = llvm.getelementptr %4[%3, %3] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.getelementptr %2[%3, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = llvm.call @sprintf(%arg1, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %7, %8 : !llvm.ptr<i32>
    %9 = llvm.call @sprintf(%arg1, %5, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    %10 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %9, %10 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @fold_snprintf_past_end(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i8>, %arg2: i64) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %5 = llvm.getelementptr %4[%3, %3] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %6 = llvm.getelementptr %2[%3, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = llvm.call @snprintf(%arg1, %arg2, %6) : (!llvm.ptr<i8>, i64, !llvm.ptr<i8>) -> i32
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %7, %8 : !llvm.ptr<i32>
    %9 = llvm.call @snprintf(%arg1, %arg2, %5, %6) : (!llvm.ptr<i8>, i64, !llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    %10 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %9, %10 : !llvm.ptr<i32>
    llvm.return
  }
}
