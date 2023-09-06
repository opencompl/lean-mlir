module  {
  llvm.mlir.global external constant @ax() : !llvm.array<8 x i8>
  llvm.mlir.global external constant @a01230123("01230123")
  llvm.mlir.global external constant @b01230123("01230123")
  llvm.mlir.global external constant @c01230129("01230129")
  llvm.mlir.global external constant @d9123_12("9123\0012")
  llvm.mlir.global external constant @e9123_34("9123\0034")
  llvm.func @strncmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
  llvm.func @fold_strncmp_a_b_n(%arg0: !llvm.ptr<i32>, %arg1: i64) {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.mlir.addressof @b01230123 : !llvm.ptr<array<8 x i8>>
    %3 = llvm.mlir.constant(4 : i64) : i64
    %4 = llvm.mlir.addressof @b01230123 : !llvm.ptr<array<8 x i8>>
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.addressof @b01230123 : !llvm.ptr<array<8 x i8>>
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.addressof @b01230123 : !llvm.ptr<array<8 x i8>>
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.mlir.addressof @b01230123 : !llvm.ptr<array<8 x i8>>
    %11 = llvm.mlir.addressof @b01230123 : !llvm.ptr<array<8 x i8>>
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.addressof @a01230123 : !llvm.ptr<array<8 x i8>>
    %14 = llvm.getelementptr %13[%12, %12] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %15 = llvm.getelementptr %11[%12, %12] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %16 = llvm.getelementptr %10[%12, %9] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %17 = llvm.getelementptr %8[%12, %7] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %18 = llvm.getelementptr %6[%12, %5] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %19 = llvm.getelementptr %4[%12, %3] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %20 = llvm.getelementptr %2[%12, %1] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %21 = llvm.call @strncmp(%14, %15, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %22 = llvm.getelementptr %arg0[%12] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %21, %22 : !llvm.ptr<i32>
    %23 = llvm.call @strncmp(%14, %16, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %24 = llvm.getelementptr %arg0[%9] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %23, %24 : !llvm.ptr<i32>
    %25 = llvm.call @strncmp(%14, %17, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %26 = llvm.getelementptr %arg0[%7] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %25, %26 : !llvm.ptr<i32>
    %27 = llvm.call @strncmp(%14, %18, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %28 = llvm.getelementptr %arg0[%5] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %27, %28 : !llvm.ptr<i32>
    %29 = llvm.call @strncmp(%14, %19, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %30 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %29, %30 : !llvm.ptr<i32>
    %31 = llvm.call @strncmp(%14, %20, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %32 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %31, %32 : !llvm.ptr<i32>
    %33 = llvm.call @strncmp(%20, %14, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %34 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %33, %34 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @call_strncmp_a_ax_n(%arg0: !llvm.ptr<i32>, %arg1: i64) {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr<array<8 x i8>>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @a01230123 : !llvm.ptr<array<8 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.getelementptr %0[%1, %1] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @strncmp(%3, %4, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %6 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %5, %6 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @fold_strncmp_a_c_n(%arg0: !llvm.ptr<i32>, %arg1: i64) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.addressof @c01230129 : !llvm.ptr<array<8 x i8>>
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.addressof @c01230129 : !llvm.ptr<array<8 x i8>>
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.mlir.addressof @c01230129 : !llvm.ptr<array<8 x i8>>
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.addressof @c01230129 : !llvm.ptr<array<8 x i8>>
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.mlir.addressof @c01230129 : !llvm.ptr<array<8 x i8>>
    %10 = llvm.mlir.addressof @c01230129 : !llvm.ptr<array<8 x i8>>
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.addressof @a01230123 : !llvm.ptr<array<8 x i8>>
    %13 = llvm.getelementptr %12[%11, %11] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %14 = llvm.getelementptr %10[%11, %11] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %15 = llvm.getelementptr %9[%11, %8] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %16 = llvm.getelementptr %7[%11, %6] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %17 = llvm.getelementptr %5[%11, %4] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %18 = llvm.getelementptr %3[%11, %2] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %19 = llvm.getelementptr %1[%11, %0] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %20 = llvm.call @strncmp(%13, %14, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %21 = llvm.getelementptr %arg0[%11] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %20, %21 : !llvm.ptr<i32>
    %22 = llvm.call @strncmp(%13, %15, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %23 = llvm.getelementptr %arg0[%8] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %22, %23 : !llvm.ptr<i32>
    %24 = llvm.call @strncmp(%13, %16, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %25 = llvm.getelementptr %arg0[%6] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %24, %25 : !llvm.ptr<i32>
    %26 = llvm.call @strncmp(%13, %17, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %27 = llvm.getelementptr %arg0[%4] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %26, %27 : !llvm.ptr<i32>
    %28 = llvm.call @strncmp(%13, %18, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %29 = llvm.getelementptr %arg0[%2] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %28, %29 : !llvm.ptr<i32>
    %30 = llvm.call @strncmp(%13, %18, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %31 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %30, %31 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @fold_strncmp_a_d_n(%arg0: !llvm.ptr<i32>, %arg1: i64) {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.addressof @d9123_12 : !llvm.ptr<array<7 x i8>>
    %2 = llvm.mlir.addressof @d9123_12 : !llvm.ptr<array<7 x i8>>
    %3 = llvm.mlir.addressof @d9123_12 : !llvm.ptr<array<7 x i8>>
    %4 = llvm.mlir.addressof @d9123_12 : !llvm.ptr<array<7 x i8>>
    %5 = llvm.mlir.addressof @d9123_12 : !llvm.ptr<array<7 x i8>>
    %6 = llvm.mlir.addressof @d9123_12 : !llvm.ptr<array<7 x i8>>
    %7 = llvm.mlir.addressof @d9123_12 : !llvm.ptr<array<7 x i8>>
    %8 = llvm.mlir.constant(6 : i64) : i64
    %9 = llvm.mlir.addressof @a01230123 : !llvm.ptr<array<8 x i8>>
    %10 = llvm.mlir.constant(5 : i64) : i64
    %11 = llvm.mlir.addressof @a01230123 : !llvm.ptr<array<8 x i8>>
    %12 = llvm.mlir.constant(4 : i64) : i64
    %13 = llvm.mlir.addressof @a01230123 : !llvm.ptr<array<8 x i8>>
    %14 = llvm.mlir.constant(3 : i64) : i64
    %15 = llvm.mlir.addressof @a01230123 : !llvm.ptr<array<8 x i8>>
    %16 = llvm.mlir.constant(2 : i64) : i64
    %17 = llvm.mlir.addressof @a01230123 : !llvm.ptr<array<8 x i8>>
    %18 = llvm.mlir.constant(1 : i64) : i64
    %19 = llvm.mlir.addressof @a01230123 : !llvm.ptr<array<8 x i8>>
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.mlir.addressof @a01230123 : !llvm.ptr<array<8 x i8>>
    %22 = llvm.getelementptr %21[%20, %20] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %23 = llvm.getelementptr %19[%20, %18] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %24 = llvm.getelementptr %17[%20, %16] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %25 = llvm.getelementptr %15[%20, %14] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %26 = llvm.getelementptr %13[%20, %12] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %27 = llvm.getelementptr %11[%20, %10] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %28 = llvm.getelementptr %9[%20, %8] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %29 = llvm.getelementptr %7[%20, %20] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %30 = llvm.getelementptr %6[%20, %18] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %31 = llvm.getelementptr %5[%20, %16] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %32 = llvm.getelementptr %4[%20, %14] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %33 = llvm.getelementptr %3[%20, %12] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %34 = llvm.getelementptr %2[%20, %10] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %35 = llvm.getelementptr %1[%20, %8] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %36 = llvm.call @strncmp(%22, %29, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %37 = llvm.getelementptr %arg0[%20] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %36, %37 : !llvm.ptr<i32>
    %38 = llvm.call @strncmp(%22, %30, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %39 = llvm.getelementptr %arg0[%18] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %38, %39 : !llvm.ptr<i32>
    %40 = llvm.call @strncmp(%23, %30, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %41 = llvm.getelementptr %arg0[%16] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %40, %41 : !llvm.ptr<i32>
    %42 = llvm.call @strncmp(%24, %31, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %43 = llvm.getelementptr %arg0[%14] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %42, %43 : !llvm.ptr<i32>
    %44 = llvm.call @strncmp(%25, %32, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %45 = llvm.getelementptr %arg0[%12] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %44, %45 : !llvm.ptr<i32>
    %46 = llvm.call @strncmp(%26, %33, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %47 = llvm.getelementptr %arg0[%12] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %46, %47 : !llvm.ptr<i32>
    %48 = llvm.call @strncmp(%33, %26, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %49 = llvm.getelementptr %arg0[%10] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %48, %49 : !llvm.ptr<i32>
    %50 = llvm.call @strncmp(%27, %34, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %51 = llvm.getelementptr %arg0[%8] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %50, %51 : !llvm.ptr<i32>
    %52 = llvm.call @strncmp(%28, %35, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %53 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %52, %53 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @fold_strncmp_a_d_nz(%arg0: !llvm.ptr<i32>, %arg1: i64) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @d9123_12 : !llvm.ptr<array<7 x i8>>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @a01230123 : !llvm.ptr<array<8 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %6 = llvm.or %arg1, %0  : i64
    %7 = llvm.call @strncmp(%4, %5, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %8 = llvm.getelementptr %arg0[%2] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %7, %8 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @fold_strncmp_d_e_n(%arg0: !llvm.ptr<i32>, %arg1: i64) {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.addressof @e9123_34 : !llvm.ptr<array<7 x i8>>
    %3 = llvm.mlir.addressof @e9123_34 : !llvm.ptr<array<7 x i8>>
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.addressof @d9123_12 : !llvm.ptr<array<7 x i8>>
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.addressof @d9123_12 : !llvm.ptr<array<7 x i8>>
    %8 = llvm.getelementptr %7[%6, %6] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %9 = llvm.getelementptr %5[%6, %4] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %10 = llvm.getelementptr %3[%6, %6] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %11 = llvm.getelementptr %2[%6, %4] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %12 = llvm.call @strncmp(%8, %10, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %13 = llvm.getelementptr %arg0[%6] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %12, %13 : !llvm.ptr<i32>
    %14 = llvm.call @strncmp(%8, %11, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %15 = llvm.getelementptr %arg0[%4] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %14, %15 : !llvm.ptr<i32>
    %16 = llvm.call @strncmp(%9, %10, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %17 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %16, %17 : !llvm.ptr<i32>
    %18 = llvm.call @strncmp(%9, %11, %arg1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %19 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %18, %19 : !llvm.ptr<i32>
    llvm.return
  }
}
